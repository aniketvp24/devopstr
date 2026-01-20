# Import libraries
import pickle
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

# Load data
train = pd.read_csv('datasets/train.csv')
test =  pd.read_csv('datasets/test.csv')

# Train a simple model
model = RandomForestClassifier(n_estimators=50, random_state=42)
model.fit(
	train.drop('class', axis=1),
	train['class']
)
print('Trained the model.')

# Check and report performance
predictions = model.predict(test.drop('class', axis=1))
accuracy = accuracy_score(test['class'], predictions) * 100
print(f'Model accuracy: {accuracy:.2f}%')

# Save the model
with open('model_iris.pkl', 'wb') as f:
	pickle.dump(model, f)
	
print('Model saved: model_iris.pkl')
