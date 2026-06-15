from pydantic import BaseModel


class BattleRunRequest(BaseModel):
    rank: str             # e.g., "phantom"
    language: str         # "cpp", "java", etc.
    problem_id: str       # e.g., "cpp_phantom_001"
    code: str
    input_data: str = ""  # Custom input typed by the user

class BattleUserSubmission(BaseModel):
    user_id: str
    language: str
    problem_id: str       # Crucial: ID might differ by language (e.g., cpp_phantom_001 vs py_phantom_001)
    code: str

class BattleSubmitRequest(BaseModel):
    battle_id: str        
    rank: str             # e.g., "phantom"
    user_a: BattleUserSubmission
    user_b: BattleUserSubmission