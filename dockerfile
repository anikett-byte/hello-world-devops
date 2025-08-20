# Use official Python slim base image
FROM python:3.10-slim

WORKDIR /app
COPY app/requirements.txt /app
RUN pip install -r requirements.txt
COPY app/ /app

CMD ["python", "main.py"]
