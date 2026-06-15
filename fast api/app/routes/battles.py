import json
from fastapi import APIRouter, HTTPException, Depends
from app.core.engine.part5_runner.battle_runner import execute_single_test, evaluate_battle_submission
from app.core.linters.linter import run_linter
from app.core.ai_feedback.feedback import generate_battle_judgment
from app.models.battle_model import BattleRunRequest, BattleSubmitRequest
from app.security.check_user import supabase, verify_supabase_user
from app.filter.filter_code import CodeSecurityFilter, Severity

router = APIRouter()

# Initialize the code safety filter for incoming submissions
security_filter = CodeSecurityFilter()


def fetch_problem_securely(rank: str, language: str, problem_id: str):
    """
    Securely fetches specific problem configurations from Supabase Storage buckets.
    """
    try:
        path = f"part5_battles/{rank.lower()}/{language.lower()}_{rank.lower()}.json"
        data = supabase.storage.from_("battles").download(path)
        config = json.loads(data)
        problem = next((p for p in config["problems"] if p["problem_id"] == problem_id), None)
        return problem
    except Exception as e:
        print(f"Supabase Storage Error: {str(e)}")
        return None


# ==========================================
# 1. Quick Run Endpoint (Sandbox Testing)
# ==========================================
@router.post("/run")
def run_battle_code(
    req: BattleRunRequest,
    user=Depends(verify_supabase_user)
):
    """
    Executes code against custom input during a live battle. 
    Secured via Supabase JWT and the AST Code Security Filter.
    """
    # Security Layer: Check for system-breaking or malicious commands
    is_safe, violations = security_filter.analyze_code(req.code)
    if not is_safe:
        critical_reasons = [v.reason for v in violations if v.severity in [Severity.CRITICAL, Severity.HIGH]]
        raise HTTPException(
            status_code=403,
            detail={
                "status": "ban_user",
                "action": "logout_and_ban",
                "message": "Malicious code execution blocked in sandbox.",
                "violations": critical_reasons
            }
        )

    # Fetch problem to grab the execution configuration parameters
    problem = fetch_problem_securely(req.rank, req.language, req.problem_id)
    if not problem: 
        raise HTTPException(status_code=404, detail="Problem configuration not found.")

    timeout = problem["execution_config"]["timeout_seconds"]

    # Spin up the single isolated Docker container
    result = execute_single_test(req.language, req.code, req.input_data, timeout)
    return result


# ==========================================
# 2. Final Submit Endpoint (The PvP Pipeline)
# ==========================================
@router.post("/submit")
def submit_battle_code(
    req: BattleSubmitRequest,
    user=Depends(verify_supabase_user)
):
    """
    Evaluates both competitors, runs static analysis quality linters, 
    and triggers the fallback AI engine to compute the final 50-point judgment.
    """
    # --- Security Layer: Scan Both Code Submissions ---
    is_safe_a, violations_a = security_filter.analyze_code(req.user_a.code)
    is_safe_b, violations_b = security_filter.analyze_code(req.user_b.code)

    if not is_safe_a or not is_safe_b:
        offending_user = "User A" if not is_safe_a else "User B"
        violations = violations_a if not is_safe_a else violations_b
        critical_reasons = [v.reason for v in violations if v.severity in [Severity.CRITICAL, Severity.HIGH]]
        
        raise HTTPException(
            status_code=403,
            detail={
                "status": "ban_user",
                "action": "logout_and_ban",
                "message": f"Malicious syntax injection discovered from {offending_user}. Match terminated.",
                "violations": critical_reasons
            }
        )

    # 1. Fetch JSON test matrices for both problem identifiers
    problem_a = fetch_problem_securely(req.rank, req.user_a.language, req.user_a.problem_id)
    problem_b = fetch_problem_securely(req.rank, req.user_b.language, req.user_b.problem_id)

    if not problem_a or not problem_b:
        raise HTTPException(status_code=404, detail="One or both targeted battle data profiles do not exist.")

    # 2. Execute Docker verification loops
    payload_a = {"language": req.user_a.language, "code": req.user_a.code}
    payload_b = {"language": req.user_b.language, "code": req.user_b.code}
    
    docker_metrics_a = evaluate_battle_submission(payload_a, problem_a)
    docker_metrics_b = evaluate_battle_submission(payload_b, problem_b)

    # 3. Analyze code styling and layout quality metrics
    linter_metrics_a = run_linter(req.user_a.language, req.user_a.code)
    linter_metrics_b = run_linter(req.user_b.language, req.user_b.code)

    # 4. Construct structural payload mapping for the judgment engine
    ai_payload_dict = {
        "user_A": {
            "user_id": req.user_a.user_id,
            "language": req.user_a.language,
            "code_submitted": req.user_a.code,
            "docker_metrics": docker_metrics_a,
            "linter_metrics": linter_metrics_a
        },
        "user_B": {
            "user_id": req.user_b.user_id,
            "language": req.user_b.language,
            "code_submitted": req.user_b.code,
            "docker_metrics": docker_metrics_b,
            "linter_metrics": linter_metrics_b
        }
    }

    # 5. Hand over processing to the prompt compilation and fallback logic
    final_judgment = generate_battle_judgment(rank=req.rank, payload_dict=ai_payload_dict)

    if final_judgment.get("status") == "error":
        raise HTTPException(status_code=503, detail=final_judgment.get("message"))

    # 6. Return response tracking maps straight to the client
    return {
        "battle_id": req.battle_id,
        "status": "completed",
        "results": final_judgment
    }