import os
import werkzeug
from flask import Flask, request, jsonify
from predict import getData

app = Flask(__name__)

@app.route('/upload', methods = ['POST'])
def upload():
    if (request.method == 'POST'):
        getImageFile = request.files['imageDetect']
        filename = werkzeug.utils.secure_filename(getImageFile.filename)
        getImageFile.save("./getUpload/" + filename)
        prediction = getData("./getUpload/" + filename)
        return prediction
    
if __name__ == '__main__':
    app.run(debug=True, port=5050)
