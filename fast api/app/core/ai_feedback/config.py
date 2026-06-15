# config.py->prepares the ai models from openroute 
import os
from dotenv import load_dotenv
from openai import OpenAI

load_dotenv()

OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")

if not OPENROUTER_API_KEY:
    raise ValueError("OPENROUTER_API_KEY not found")

client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key=OPENROUTER_API_KEY,
)

MODELS = {
    "primary": "nvidia/llama-3.1-nemotron-ultra-253b-v1:free",
    "fallback_1": "poolside/laguna-m1:free",
    "fallback_2": "qwen/qwen3-coder:free",
}


def get_model_priority():
    return [
        MODELS["primary"],
        MODELS["fallback_1"],
        MODELS["fallback_2"],
    ]