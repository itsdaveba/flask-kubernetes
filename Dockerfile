# syntax=docker/dockerfile:1

FROM python:3.10-alpine

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py app.py

CMD ["python", "-m" , "flask", "run", "--host=0.0.0.0"]
