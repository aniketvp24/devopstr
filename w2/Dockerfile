FROM python:3.10-slim

WORKDIR /app

COPY data/iris.csv /app/data/iris.csv

COPY model.py .

RUN pip install --no-cache-dir pandas scikit-learn

ENTRYPOINT ["python"]

CMD ["model.py"]
