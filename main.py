from fastapi import FastAPI
from pydantic import BaseModel
import boto3
import json
import os
import io

app = FastAPI()

bucket_name = "mem-bucket-tallerec2"
s3 = boto3.client('s3')

class Persona(BaseModel):
    nombre: str
    edad: int
    estatura: float

@app.post("/insert")
async def insert(persona: Persona):
    p = persona.model_dump()

    json_bytes = json.dumps(p, ensure_ascii=False, indent=4).encode("utf-8")
    file_name = f"{persona.nombre}.json"

    s3.upload_fileobj(io.BytesIO(json_bytes), bucket_name, file_name)
    archivos = s3.list_objects_v2(Bucket=bucket_name)

    lista_archivos = [obj['Key'] for obj in archivos.get('Contents', [])]

    return {"mensaje": f"Archivo '{file_name}' guardado correctamente.","Cantidad archivos en el bucket":len(lista_archivos) ,"archivos": lista_archivos}

@app.get("/")
async def root():
    return {"mensaje":"API funciona yay"}