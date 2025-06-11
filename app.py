from flask import Flask, request, jsonify
import tensorflow as tf
from tensorflow.keras.models import load_model
import numpy as np
import io
from PIL import Image
import os

app = Flask(__name__)

# Path to the model
MODEL_PATH = 'C:/Users/LIKE/StudioProjects/save_knee_24/assets/model/knee_3_88.40 (2).h5'

# Load the model
try:
    model = load_model(MODEL_PATH)
except (OSError, ValueError) as e:
    print(f"Error loading model: {e}")
    model = None

@app.route('/')
def index():
    return 'Hello, World!'

@app.route('/classify', methods=['POST'])
def classify_image():
    if not model:
        return jsonify({'error': 'Model not loaded'}), 500

    if 'image' not in request.files:
        return jsonify({'error': 'No image provided'}), 400

    file = request.files['image']
    img = Image.open(io.BytesIO(file.read()))
    img = img.resize((224, 224))  # Adjust the size as needed
    img = np.array(img).astype(np.float32)
    img = (img / 255.0)  # Normalize the image to be between [0, 1]
    img = np.expand_dims(img, axis=0)  # Add batch dimension

    # Make prediction
    predictions = model.predict(img)
    results = np.squeeze(predictions)

    # Load labels (assuming the labels are stored in a file)
    labels_path = 'C:/Users/LIKE/StudioProjects/save_knee_24/assets/model/labels.txt'
    with open(labels_path, 'r') as f:
        labels = [line.strip() for line in f.readlines()]

    # Get top 3 results with confidence
    top_k = results.argsort()[-3:][::-1]  # Get top three results
    response = []
    for i in top_k:
        response.append({
            'label': labels[i],
            'confidence': float(results[i])
        })

    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)