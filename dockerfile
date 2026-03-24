FROM python:3.9-slim
WORKDIR /app
COPY requirements/prod.txt .
RUN pip install -r prod.txt
COPY . .
EXPOSE 5000
CMD ["flask", "--app", "autoapp", "run", "--with-threads", "--host=0.0.0.0"]