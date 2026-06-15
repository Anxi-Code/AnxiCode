# debug_runner file (runs docker for part 4 only)
import subprocess
import tempfile
import os

# Map the languages from Flutter to our Docker images
LANGUAGE_CONFIG = {
    "python": {"ext": ".py", "image": "anxi-python", "filename": "main.py"},
    "cpp": {"ext": ".cpp", "image": "anxi-cpp", "filename": "main.cpp"},
    "javascript": {"ext": ".js", "image": "anxi-js", "filename": "main.js"},
    "java": {"ext": ".java", "image": "anxi-java", "filename": "Main.java"},
}

def execute_code(language: str, code: str, input_data: str = "", timeout: int = 3):
    config = LANGUAGE_CONFIG.get(language.lower())
    if not config:
        return {"success": False, "error": f"Language {language} not supported."}

    # Create a self-destructing temporary directory
    with tempfile.TemporaryDirectory() as temp_dir:
        file_path = os.path.join(temp_dir, config["filename"])

        # 1. Write the user's code to the temp file
        with open(file_path, "w") as f:
            f.write(code)

        # 2. Build the ultra-secure Docker command
        cmd = [
            "docker", "run", "--rm",        # Delete container immediately after running
            "-i",                           # Keep standard input open for test cases
            "--net", "none",                # SECURITY: Block all internet access
            "--memory", "128m",             # SECURITY: Max 128MB RAM
            "--cpus", "0.5",                # SECURITY: Max 50% of 1 CPU core
            "-v", f"{temp_dir}:/sandbox",   # Mount the temp folder into the container
            config["image"]
        ]

        try:
            # 3. Fire the container!
            process = subprocess.run(
                cmd,
                input=input_data,
                text=True,
                capture_output=True,
                timeout=timeout
            )
            
            # 4. Return the results
            if process.returncode != 0:
                return {"success": False, "output": process.stderr.strip() or process.stdout.strip()}
                
            return {"success": True, "output": process.stdout.strip()}
            
        except subprocess.TimeoutExpired:
            return {"success": False, "error": f"Execution timed out after {timeout} seconds. Infinite loop detected."}
        except Exception as e:
            return {"success": False, "error": str(e)}
