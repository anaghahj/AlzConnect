from flask import Flask,request,jsonify,render_template,send_from_directory,Blueprint
from routes import webdata_routes
from flask_cors import CORS
import os,pymongo,routes
from gridfs import GridFS
import torch
from PIL import Image
from torchvision import models,transforms

device = torch.device('cpu')
app = Flask(__name__)
CORS(app)
client = pymongo.MongoClient("<MONGO DB CONNECTION STRING LINK>")
db = client['Spryzen']
collection = db['webdatas']
usercollection = db['users']
fs = GridFS(db)
webdata_routes = Blueprint('webdata_routes', __name__)

@webdata_routes.route('/api/webdatas', methods=['GET'])
def get_all_webdata():
    webdata = list(collection.find({}))
    return jsonify(webdata)

@webdata_routes.route('/api/webdatas', methods=['POST'])
def add_webdata():
    data = request.get_json()
    # Assuming data contains 'name', 'password', 'email', 'phno', 'age', 'bloodgrp', 'gender', 'desc'
    result = collection.insert_one(data)
    return jsonify({"message": "WebData added successfully!", "inserted_id": str(result.inserted_id)})

@app.route('/forgot', methods=['GET','POST'])
def forgot():
    if request.method == 'GET':
        return render_template('forgot.ejs')
    name = request.form['username']
    pwd = request.form['password']
    conpwd = request.form['confirmpassword']
    if pwd==conpwd :
        if usercollection.find_one({'name':name}) is not None:
            usercollection.find_one_and_update({"name": name}, {'$set': {'password': pwd}})
            collection.find_one_and_update({"name": name}, {'$set': {'password': pwd}})
            return render_template('login.ejs')
        return render_template('errorforgot.ejs')
    return render_template('errorpwd.ejs')


@app.route('/checkprogres', methods=['POST'])
def checkprogres():
    mri_scan = request.files['mriScan']
    if mri_scan:
        PATH_TO_MODEL='resnet50_best_ckpt.pth'
        PATH_TO_IMAGE= mri_scan
        #model1 = model()  # Initialize model
        model1 = models.resnet50(pretrained=True)
        model1.fc = torch.nn.Linear(2048, 3)
        model1 = model1.to(device) 

        model1.load_state_dict(torch.load(PATH_TO_MODEL))  # Load pretrained parameters
        model1.eval()  # Set to eval mode to change behavior of Dropout, BatchNorm

        transform = transforms.Compose([transforms.Resize((256, 170)), transforms.ToTensor()])  # Same as for your validation data, e.g. Resize, ToTensor, Normalize, ...

        img = Image.open(PATH_TO_IMAGE).convert('RGB')  # Load image as PIL.Image
        x = transform(img)  # Preprocess image
        x = x.unsqueeze(0)  # Add batch dimension

        output = model1(x)  # Forward pass
        pred = torch.argmax(output, 1).item()# Get predicted class if multi-class classification
        print('Image predicted as ', pred)
        return render_template('checkprogress.ejs', pred = pred)
    return render_template('mriscan.ejs')

@app.route('/')
def main():
    return render_template('frontpage.ejs') 

@app.route('/login/', methods=["GET", "POST"])
def login():
    if request.method == "POST":
        # Handle the login logic here
        # Access form data using request.form['input_name']
        username = request.form['name']
        password = request.form['password']

        # Query the MongoDB to find the user
        user = collection.find_one({"name": username})

        if user and user["password"] == password:
            # Successful login
            return render_template("mriscan.ejs")
        else:
            # Invalid credentials
            return render_template("signup.ejs")

    return render_template("login.ejs")

@app.route("/signup", methods=["GET", "POST"])
def signup():
    if request.method == "POST":
        # Handle the signup logic here
        # Access form data using request.form['input_name']
        username = request.form['username']
        password = request.form['password']
        conpwd = request.form['confirmpassword']

        # Check if the username already exists in the database
        existing_user = usercollection.find_one({"name": username})
        if existing_user:
            return render_template("error404.ejs")
        else:
            if password == conpwd:
                # Insert the new user into the database
                newCred = {
                    "name": username,
                    "password": password
                }
                usercollection.insert_one(newCred)
                collection.insert_one(newCred)
                return render_template("mainpage.ejs")
            return render_template('errorpwd.ejs')

    return render_template("signup.ejs")

# Register the webdata_routes blueprint
app.register_blueprint(webdata_routes)

@app.route('/checkprogresss',methods=['POST'])
def check_progresss():
    return render_template('checkprogress.ejs')
    

@app.route('/checkprogress', methods=['POST'])
def check_progress():
    # Get the data from the form
    name = request.form['name']

    # Use $set to update the fields without overwriting the "name" field
    update_data = {
        "$set": {
            "email": request.form['email'],
            "phno": request.form['phone'],
            "age": request.form['age'],
            "bloodgrp": request.form['bloodGroup'],
            "gender": request.form['gender'],
            "desc": request.form['medicalCondition']
        }
    }
    mri_scan = request.files['mriScan']
    
    if mri_scan:
        PATH_TO_MODEL='resnet50_best_ckpt.pth'
        PATH_TO_IMAGE= mri_scan
        #model1 = model()  # Initialize model
        model1 = models.resnet50(pretrained=True)
        model1.fc = torch.nn.Linear(2048, 3)
        model1 = model1.to(device) 

        model1.load_state_dict(torch.load(PATH_TO_MODEL))  # Load pretrained parameters
        model1.eval()  # Set to eval mode to change behavior of Dropout, BatchNorm

        transform = transforms.Compose([transforms.Resize((256, 170)), transforms.ToTensor()])  # Same as for your validation data, e.g. Resize, ToTensor, Normalize, ...

        img = Image.open(PATH_TO_IMAGE).convert('RGB')  # Load image as PIL.Image
        x = transform(img)  # Preprocess image
        x = x.unsqueeze(0)  # Add batch dimension

        output = model1(x)  # Forward pass
        pred = torch.argmax(output).item()  # Get predicted class if multi-class classification
        print('Image predicted as ', pred)
        return render_template('checkprogress.ejs', pred = pred)
    # return render_template('mriscan.ejs')
    # Update the data in the MongoDB collection based on the "name"
    try:
        result = collection.find_one({"name":name})
        # result = collection.update_one({"name": name}, update_data)
        if result == collection.find_one({"name":name}):
            collection.find_one_and_update({"name":name},update_data)
            print("Data updated successfully.")
            # Redirect or render the appropriate template
            return render_template('checkprogress.ejs')
        else:
            print("Data not found.")
            return "Data not found."
    
    except Exception as e:
        print("Error updating data:", str(e))
        return "Error updating data."


@app.route('/care', methods=['GET'])
def care():
    return render_template("care.ejs")

@app.route('/privacypolicy', methods=['GET'])
def privacy():
    return render_template("privacypolicy.ejs")

@app.route('/termsofuse', methods=['GET'])
def terms():
    return render_template('termsofuse.ejs')

@app.route('/contact', methods=['GET'])
def contact():
    return render_template('contact.ejs')

@app.route('/knowmore', methods=['GET'])
def knowmore():
    return render_template('knowmore.ejs')

if __name__=="__main__":
    app.run(debug=True)
