from pydantic import BaseModel


class DebugModel(BaseModel):
    task_id: int
    rank: str
    description: str
    language: str
    code_user_debuged: str
