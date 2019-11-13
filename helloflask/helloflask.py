from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World! I now run through uWSGI and NGINX with SSL"

if __name__ == "__main__":
    app.run()
