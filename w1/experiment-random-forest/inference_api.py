import pickle
from fastapi import FastAPI
from pydantic import BaseModel, NonNegativeFloat

class InputData(BaseModel):
    sepal_length: NonNegativeFloat
    sepal_width: NonNegativeFloat
    petal_length: NonNegativeFloat
    petal_width: NonNegativeFloat


app = FastAPI()


@app.get('/')
async def root():
    return {'message': 'Welcome to the Iris inference server!'}


@app.post('/predict')
async def predict(data: InputData):
    with open('model_iris.pkl', 'rb') as f:
        model = pickle.load(f)

    features = [[
        getattr(data, feature)
        for feature in model.feature_names_in_
    ]]

    prediction = model.predict(features)
    return {"prediction": prediction[0]}

