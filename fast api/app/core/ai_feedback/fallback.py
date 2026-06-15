# fallback.py-> handles the ai models fall back 
import logging
from openai import OpenAIError
from app.core.ai_feedback.config import client, get_model_priority

# Set up logging so you can see model failures in your FastAPI terminal
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("OpenRouterFallback")

def generate_chat_completion_with_fallback(system_prompt: str, user_payload: str):
    """
    Attempts to generate an AI completion using OpenRouter.
    If the primary model fails, it sequentially cascades down to the fallbacks.
    """
    models_to_try = get_model_priority()
    
    # Format the message structure for standard chat completion
    messages = [
        {"role": "system", "content": system_prompt},
        {"role": "user", "content": user_payload}
    ]

    # Iterate through the models in strict order of priority
    for index, model_name in enumerate(models_to_try):
        try:
            logger.info(f"Attempting compilation judgment with model ({index + 1}/{len(models_to_try)}): {model_name}")
            
            # Execute the OpenRouter API call
            response = client.chat.completions.create(
                model=model_name,
                messages=messages,
                # Enforce JSON formatting at the provider level where supported
                response_format={"type": "json_object"} 
            )
            
            # Extract content cleanly if successful
            ai_content = response.choices[0].message.content
            logger.info(f"Successfully generated response using model: {model_name}")
            
            return {
                "success": True,
                "model_used": model_name,
                "feedback": ai_content
            }

        except OpenAIError as e:
            # Catch API connection errors, rate limits, or timeouts
            logger.error(f"Model {model_name} failed. Error details: {str(e)}")
            continue  # Proceed smoothly to the next model in the list
            
        except Exception as e:
            # Catch generic unexpected system failures
            logger.error(f"Unexpected error with model {model_name}: {str(e)}")
            continue

    # If the loop finishes without a return, all models have failed
    logger.critical("All configured OpenRouter models failed to respond.")
    return {
        "success": False,
        "error": "All AI judging models are currently unavailable. Please try again shortly."
    }