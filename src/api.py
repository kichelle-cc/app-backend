from fastapi import FastAPI
from datetime import datetime

app = FastAPI()

@app.get("/")
@app.get("/index")
async def read_root():
    now = datetime.now()
    current_time = now.strftime("%H:%M:%S")
    return {"Current Time": current_time}
