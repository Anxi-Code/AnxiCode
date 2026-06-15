# feedback.py->gets the ai response 
import json
import logging
from app.core.ai_feedback.fallback import generate_chat_completion_with_fallback
from app.core.ai_feedback.ai_prompt import get_battle_system_prompt, format_user_payload

logger = logging.getLogger("FeedbackEngine")

def calculate_50_point_score(user_data: dict, ai_elegance_score: float, opponent_time_ms: float) -> float:
    """
    Calculates the final score out of 50.
    - Test Cases (10 pts): Proportional to passed/total.
    - Linters (10 pts): Taken directly from the linter engine.
    - AI Elegance (10 pts): Awarded by the OpenRouter AI.
    - Execution Speed (20 pts): Faster code gets 20, slower gets proportional points.
    """
    docker_stats = user_data["docker_metrics"]
    
    # 1. Test Case Score (10 points max)
    passed = docker_stats["test_cases_passed_count"]
    total = docker_stats["total_test_cases"]
    test_score = (passed / total) * 10.0 if total > 0 else 0.0

    # 2. Linter Score (10 points max)
    linter_score = user_data["linter_metrics"]["linter_score"]

    # 3. AI Elegance Score (10 points max) - Passed in from AI response
    ai_score = float(ai_elegance_score)

    # 4. Execution Speed Score (20 points max)
    my_time = docker_stats["total_execution_time_ms"]
    
    # If the user failed test cases, penalize their execution score severely
    if not docker_stats["all_tests_passed"]:
        execution_score = 5.0 
    # If they are faster or tied, they get the full 20 points
    elif my_time <= opponent_time_ms:
        execution_score = 20.0
    # If they are slower, they get a proportional score (minimum 10 points for passing everything)
    else:
        speed_ratio = opponent_time_ms / my_time if my_time > 0 else 1
        execution_score = max(10.0, round(20.0 * speed_ratio, 1))

    # Calculate Total
    total_score = test_score + linter_score + ai_score + execution_score
    return round(total_score, 1)


def generate_battle_judgment(rank: str, payload_dict: dict) -> dict:
    """
    The main pipeline that handles prompts, AI fallbacks, and score math.
    """
    # 1. Build the prompts
    system_prompt = get_battle_system_prompt(rank)
    user_payload_str = format_user_payload(payload_dict)

    # 2. Call the fallback system (Cycles Llama -> Laguna -> Qwen)
    ai_response = generate_chat_completion_with_fallback(system_prompt, user_payload_str)

    # 3. Parse the JSON safely
    parsed_feedback = {}
    if ai_response.get("success"):
        try:
            parsed_feedback = json.loads(ai_response.get("feedback", "{}"))
        except json.JSONDecodeError:
            logger.error("AI returned malformed JSON.")
            parsed_feedback = {
                "winner_id": "Error",
                "summary_reason": "AI formatting failed.",
                "user_a_ai_score": 0.0,
                "user_b_ai_score": 0.0,
                "raw_output": ai_response.get("feedback")
            }
    else:
        return {"status": "error", "message": ai_response.get("error")}

    # 4. Run the 50-Point Math Engine
    time_a = payload_dict["user_A"]["docker_metrics"]["total_execution_time_ms"]
    time_b = payload_dict["user_B"]["docker_metrics"]["total_execution_time_ms"]

    final_score_a = calculate_50_point_score(
        user_data=payload_dict["user_A"], 
        ai_elegance_score=parsed_feedback.get("user_a_ai_score", 0.0), 
        opponent_time_ms=time_b
    )
    
    final_score_b = calculate_50_point_score(
        user_data=payload_dict["user_B"], 
        ai_elegance_score=parsed_feedback.get("user_b_ai_score", 0.0), 
        opponent_time_ms=time_a
    )

    # 5. Return the Ultimate Judgment Package
    return {
        "status": "success",
        "winner_id": parsed_feedback.get("winner_id", "Tie"),
        "summary_reason": parsed_feedback.get("summary_reason", ""),
        "user_A": {
            "total_score_out_of_50": final_score_a,
            "ai_elegance_score": parsed_feedback.get("user_a_ai_score", 0.0),
            "ai_feedback": parsed_feedback.get("user_a_feedback", "")
        },
        "user_B": {
            "total_score_out_of_50": final_score_b,
            "ai_elegance_score": parsed_feedback.get("user_b_ai_score", 0.0),
            "ai_feedback": parsed_feedback.get("user_b_feedback", "")
        }
    }