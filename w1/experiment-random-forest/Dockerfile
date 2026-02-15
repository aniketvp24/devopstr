FROM python:3.10-slim

WORKDIR /app

COPY model_iris.pkl inference_api.py ./

RUN pip install --no-cache-dir pandas scikit-learn fastapi uvicorn

EXPOSE 8000

CMD ["uvicorn", "inference_api:app", "--host", "0.0.0.0", "--port", "8000"]