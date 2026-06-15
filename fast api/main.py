from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routes import part4_debug, battles


app = FastAPI(title="AnxiCode FYP API", version="1.0.0")


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


app.include_router(
    part4_debug.router, 
    prefix="/api/part4",
    tags=["Part 4 - Debug Forge"]
)

# Part 5: Battle Arena (PvP Engine)
app.include_router(
    battles.router, 
    prefix="/api/part5",
    tags=["Part 5 - Battle Arena"]
)

@app.get("/", tags=["Health Check"])
def health_check():
    return {"status": "online", "message": "AnxiCode Engine is locked and loaded."}