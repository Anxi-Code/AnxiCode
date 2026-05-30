from fastapi import FastAPI

app = FastAPI()

items=[]

@app.get("/items")
def get_items():
    return items
