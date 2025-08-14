FROM python:3.10-slim
<<<<<<< HEAD
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["python", "app.py"]

=======

WORKDIR /app
COPY app/ /app
COPY requirements.txt /app

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]
>>>>>>> 88c57996e1dc6efb2f17977baac3901c270d1bb0
