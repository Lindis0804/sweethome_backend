FROM python:3.10.11
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
CMD ["python","main.py"]