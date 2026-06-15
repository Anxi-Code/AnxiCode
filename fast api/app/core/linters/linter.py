import subprocess
import tempfile
import os
import re

def _run_command(command):
    try:
        result = subprocess.run(command, capture_output=True, text=True, timeout=20)
        return (result.stdout + "\n" + result.stderr).strip()
    except Exception as e:
        return str(e)

def calculate_score(error_count, penalty_per_error=0.5):
    """Starts at 10.0, deducts points per error, won't drop below 0.0"""
    return max(0.0, round(10.0 - (error_count * penalty_per_error), 1))

# --- PYTHON (Native Pylint Score) ---
def run_python_linter(code):
    with tempfile.NamedTemporaryFile(suffix=".py", delete=False, mode="w", encoding="utf-8") as file:
        file.write(code)
        path = file.name
    try:
        output = _run_command(["pylint", path])
        # Pylint literally prints: "Your code has been rated at 8.5/10"
        score_match = re.search(r"Your code has been rated at (\-?\d+\.\d+)/10", output)
        score = float(score_match.group(1)) if score_match else 0.0
        
        return {"language": "python", "linter_score": score, "raw_linter_feedback": output}
    finally:
        os.unlink(path)

# --- C++ (Cpplint - Penalty Score) ---
def run_cpp_linter(code):
    with tempfile.NamedTemporaryFile(suffix=".cpp", delete=False, mode="w", encoding="utf-8") as file:
        file.write(code)
        path = file.name
    try:
        output = _run_command(["cpplint", path])
        # Cpplint prints: "Total errors found: X" at the bottom
        match = re.search(r"Total errors found:\s+(\d+)", output)
        errors = int(match.group(1)) if match else 0
        score = calculate_score(errors)
        
        return {"language": "c++", "linter_score": score, "raw_linter_feedback": output}
    finally:
        os.unlink(path)

# --- JAVA (Checkstyle - Penalty Score) ---
def run_java_linter(code):
    with tempfile.NamedTemporaryFile(suffix=".java", delete=False, mode="w", encoding="utf-8") as file:
        file.write(code)
        path = file.name
    try:
        output = _run_command(["checkstyle", path])
        # Checkstyle tags every issue with [ERROR] or [WARN]
        errors = output.count("[ERROR]") + output.count("[WARN]")
        score = calculate_score(errors)
        
        return {"language": "java", "linter_score": score, "raw_linter_feedback": output}
    finally:
        os.unlink(path)

# --- JAVASCRIPT (ESLint - Penalty Score) ---
def run_javascript_linter(code):
    with tempfile.NamedTemporaryFile(suffix=".js", delete=False, mode="w", encoding="utf-8") as file:
        file.write(code)
        path = file.name
    try:
        output = _run_command(["eslint", path, "--no-eslintrc"])
        # ESLint prints "✖ X problems" at the bottom if there are issues
        match = re.search(r"(\d+)\s+problems?", output)
        errors = int(match.group(1)) if match else 0
        score = calculate_score(errors)
        
        return {"language": "javascript", "linter_score": score, "raw_linter_feedback": output}
    finally:
        os.unlink(path)

# main function we call this 
def run_linter(language, code):
    handlers = {
        "python": run_python_linter, 
        "cpp": run_cpp_linter, "c++": run_cpp_linter,
        "java": run_java_linter, 
        "javascript": run_javascript_linter, "js": run_javascript_linter,
    }
    handler = handlers.get(language.lower())
    
    if handler:
        return handler(code)
    else:
        return {"error": f"No linter configured for language: {language}"}