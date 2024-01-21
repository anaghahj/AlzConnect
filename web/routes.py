from flask import Blueprint, jsonify, request
from pymongo import MongoClient

# Set up the MongoDB connection
# Replace "YOUR_MONGODB_CONNECTION_STRING" with the actual connection string you used in your mongoose.connect call
client = MongoClient("<MONGO DB CONNECTION STRING>")

# Access the database and collection
db = client["Spryzen"]
collection = db["users"]

# Create a Blueprint for your webdata routes
webdata_routes = Blueprint('webdata_routes', __name__)

@webdata_routes.route('/api/AppUsers', methods=['GET'])
def get_all_webdata():
    webdatas = list(collection.find({}))
    return jsonify(webdatas)

@webdata_routes.route('/api/AppUsers', methods=['POST'])
def add_webdata():
    data = request.get_json()
    # Assuming data contains 'name', 'password', 'email', 'phno', 'age', 'bloodgrp', 'gender', 'desc'
    result = collection.insert_one(data)
    return jsonify({"message": "WebData added successfully!", "inserted_id": str(result.inserted_id)})