FROM python:3.10-slim

WORKDIR /app

# Copy requirements first and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all app files
COPY . .

# Expose port 5000 (if your Flask app uses it)
EXPOSE 5000

# Command to run the app
CMD ["python", "app.py"]

