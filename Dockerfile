FROM python:3.10-slim

WORKDIR /app

# Copy everything including requirements
COPY app/ .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000
CMD ["python", "app.py"]

