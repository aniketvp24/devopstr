# Import libraries
import os
import pickle
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

print('Current working directory:', os.getcwd())

# Load data
df = pd.read_csv('data/iris.csv')

# Train a simple model
model = RandomForestClassifier(n_estimators=50, random_state=42)
model.fit(
    df.drop('class', axis=1),
    df['class']
)
print('Trained the model.')

os.makedirs('outputs', exist_ok=True)
# Save the model
with open('outputs/model_iris.pkl', 'wb') as f:
    pickle.dump(model, f)

print('Model saved: outputs/model_iris.pkl')
