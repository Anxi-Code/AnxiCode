# runs dockers for the part 5 
import subprocess
import tempfile
import os
import time


LANGUAGE_CONFIG = {
    "python": {
        "ext": ".py", "image": "anxi-python", "filename": "main.py", 
        "memory": "128m", "cpus": "0.5"
    },
    "javascript": {
        "ext": ".js", "image": "anxi-js", "filename": "main.js", 
        "memory": "128m", "cpus": "0.5"
    },
    "cpp": {
        "ext": ".cpp", "image": "anxi-cpp", "filename": "main.cpp", 
        "memory": "256m", "cpus": "1.0" # Needs CPU for fast compilation
    },
    "java": {
        "ext": ".java", "image": "anxi-java", "filename": "Main.java", 
        "memory": "256m", "cpus": "1.0" # Needs RAM for JVM startup
    },
}

def execute_single_test(language: str, code: str, input_data: str, timeout: int):
    """
    Spins up an isolated, secure Docker container for a single test case.
    """
    config = LANGUAGE_CONFIG.get(language.lower())
    if not config:
        return {"success": False, "error": f"Language {language} not supported."}

    # Create a self-destructing temporary directory for the code
    with tempfile.TemporaryDirectory() as temp_dir:
        file_path = os.path.join(temp_dir, config["filename"])

        with open(file_path, "w", encoding="utf-8") as f:
            f.write(code)

        # The ultimate secure Docker command with dynamic hardware scaling
        cmd = [
            "docker", "run", "--rm",        
            "-i",                           
            "--net", "none",                # Block internet access (prevent cheating)
            "--memory", config["memory"],   # Dynamic RAM allocation
            "--cpus", config["cpus"],       # Dynamic CPU allocation
            "-v", f"{temp_dir}:/sandbox",   
            config["image"]
        ]

        try:
            # Fire the container and enforce the database's specific timeout
            process = subprocess.run(
                cmd,
                input=input_data,
                text=True,
                capture_output=True,
                timeout=timeout
            )
            
            if process.returncode != 0:
                return {"success": False, "output": process.stderr.strip() or process.stdout.strip()}
                
            return {"success": True, "output": process.stdout.strip()}
            
        except subprocess.TimeoutExpired:
            return {"success": False, "error": f"Execution timed out after {timeout} seconds. Code too heavy or infinite loop."}
        except Exception as e:
            return {"success": False, "error": str(e)}


def evaluate_battle_submission(user_submission: dict, problem_data: dict):
    """
    The main engine: Loops through all test cases, evaluates the code, 
    and packages isolated metrics for the AI Judge.
    """
    language = user_submission["language"]
    code = user_submission["code"]
    
    
    problem_timeout = problem_data["execution_config"]["timeout_seconds"]
    
    test_cases = problem_data["test_cases"]
    total_tests = len(test_cases)
    passed_tests = 0
    total_execution_time_ms = 0
    
    
    first_failure_reason = None 

    
    for index, test in enumerate(test_cases):
        start_time = time.time()
        
        result = execute_single_test(
            language=language, 
            code=code, 
            input_data=str(test["input"]), 
            timeout=problem_timeout
        )
        
        
        execution_time_ms = round((time.time() - start_time) * 1000, 2)
        total_execution_time_ms += execution_time_ms

        
        if result["success"]:
            
            if result["output"].strip() == str(test["expected_output"]).strip():
                passed_tests += 1
            elif first_failure_reason is None:
                first_failure_reason = f"Test Case {test['id']} Failed: Expected '{test['expected_output']}', got '{result['output']}'"
        else:
            if first_failure_reason is None:
                first_failure_reason = f"Test Case {test['id']} Error: {result.get('error') or result.get('output')}"

    
    return {
        "test_cases_passed_count": passed_tests,
        "total_test_cases": total_tests,
        "all_tests_passed": passed_tests == total_tests,
        "total_execution_time_ms": total_execution_time_ms,
        "failure_reason": first_failure_reason or "Flawless execution.",
    }