WORKDIR /app
COPY requirements.txt /app
COPY app/ /app
RUN pip install --no-cache-dir -r requirements.txt

