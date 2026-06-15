# check_user file , checks from supabase
import os
from dotenv import load_dotenv
from supabase import create_client , Client
from fastapi import Security , HTTPException 
from fastapi.security import HTTPBearer , HTTPAuthorizationCredentials

#loads .env file
load_dotenv()

# loads keys 
SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_ANON_KEY = os.getenv("SUPABASE_ANON_KEY")

# make client
supabase : Client = create_client (SUPABASE_URL , SUPABASE_ANON_KEY)

security = HTTPBearer()


def verify_supabase_user(credentials  : HTTPAuthorizationCredentials = Security(security)):
    token = credentials.credentials
    try:
        # gets the user by auth
        user_response = supabase.auth.get_user(jwt=token)
        
        # checks the user (empty or valid)
        if not user_response or not user_response.user:
            raise HTTPException(status_code=401 , detail="Invalid user token")
        return user_response.user
    
    except Exception as e:
        raise HTTPException(status_code=401 , detail=f"Unauthorized: {str(e)}")


    
