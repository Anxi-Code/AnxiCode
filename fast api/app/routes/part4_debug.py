import json
from fastapi import APIRouter, HTTPException, Depends
from app.security.check_user import supabase, verify_supabase_user
from app.models.debug_model import DebugModel
from app.core.engine.part4_runner.debug_runner import execute_code
from app.filter.filter_code import CodeSecurityFilter, Severity

router = APIRouter()

# Initialize the filter once for the router
security_filter = CodeSecurityFilter()

@router.post("/verify")
def verify_debug(
    request: DebugModel,
    user=Depends(verify_supabase_user)):

    # --- 1. Rank Progression Validation ---
    # Ensures Legendary rank cannot access sub-part routes
    if request.rank.lower() == "legendary":
        raise HTTPException(
            status_code=400,
            detail="Legendary rank bypasses sub-parts. Invalid request for Debug Forge."
        )

    # --- 2. Security Filter Check ---
    is_safe, violations = security_filter.analyze_code(request.code_user_debuged)

    if not is_safe:
        # Extract the critical/high violation reasons to send back (optional, for logging in Flutter)
        critical_reasons = [v.reason for v in violations if v.severity in [Severity.CRITICAL, Severity.HIGH]]
        
        # Return a 403 Forbidden with a specific payload for the frontend to trigger the ban
        raise HTTPException(
            status_code=403,
            detail={
                "status": "ban_user",
                "action": "logout_and_ban",
                "message": "Malicious code detected. System integrity compromised.",
                "violations": critical_reasons
            }
        )

    # --- 3. Fetch Task and Run Tests ---
    task = get_task(req=request)

    time_out = task.get("timeout", 3)
    test_cases = task.get("test_cases", [])

    if not test_cases:
        raise HTTPException(
            status_code=400,
            detail="No test cases found for this task."
        )

    return get_result(
        test_cases=test_cases,
        language=request.language,
        user_code=request.code_user_debuged,
        time_out=time_out
    )


def get_task(req: DebugModel):

    data = get_data(req=req)

    tasks_list = data.get("tasks", [])

    for task in tasks_list:
        if task.get("id") == req.task_id:
            return task

    raise HTTPException(
        status_code=404,
        detail=f"Task ID {req.task_id} not found"
    )


def get_data(req: DebugModel):

    bucket_name = req.language.lower()
    file_path = f"{req.rank.lower()}/part4_debugging/part4_debug.json"

    try:
        response = supabase.storage.from_(bucket_name).download(file_path)

        if isinstance(response, bytes):
            data_str = response.decode("utf-8")
            return json.loads(data_str)

        return json.loads(response)

    except Exception as e:
        raise HTTPException(
            status_code=404,
            detail=(
                f"Failed to fetch {file_path} "
                f"from bucket '{bucket_name}'. "
                f"Error: {str(e)}"
            )
        )


def get_result(
    test_cases,
    language,
    user_code,
    time_out
):
    results = []
    all_passed = True

    for idx, test in enumerate(test_cases):
        # runs the docker containers
        execution = execute_code(
            language=language,
            code=user_code,
            input_data=test.get("input", ""),
            timeout=time_out
        )

        if not execution["success"]:
            return {
                "status": "failed",
                "message": "Execution Error",
                "details": execution.get("error", execution.get("output"))
            }

        actual_output = (
            execution["output"]
            .strip()
            .replace("\r\n", "\n")
        )

        expected_output = (
            test.get("expected_output", "")
            .strip()
            .replace("\r\n", "\n")
        )

        passed = (
            actual_output == expected_output
        )

        results.append({
            "test_case": idx + 1,
            "passed": passed,
            "input": test.get("input", "").strip(),
            "expected": expected_output,
            "actual": actual_output
        })

        if not passed:
            all_passed = False
            break

    return {
        "status": (
            "success"
            if all_passed
            else "failed"
        ),
        "all_passed": all_passed,
        "results": results
    }