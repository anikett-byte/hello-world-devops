FROM python:3.10-slim

WORKDIR /app

# Copy everything from app/ into /app
COPY app/ .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]

