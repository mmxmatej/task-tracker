from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello, Octopus Deploy!"

if __name__ == "__main__":
    # Change the port to 80
    app.run(host='0.0.0.0', port=80)
