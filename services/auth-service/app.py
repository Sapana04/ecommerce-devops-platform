from flask import Flask, jsonify, request

app = Flask(__name__)

PORT = 3001


@app.route("/")
def home():
    return jsonify({
        "service": "Auth Service",
        "version": "1.0.0",
        "status": "Running"
    })


@app.route("/health")
def health():
    return jsonify({
        "status": "UP"
    })


@app.route("/login", methods=["POST"])
def login():

    data = request.get_json()

    username = data.get("username")

    return jsonify({
        "message": "Login Successful",
        "user": username
    })


@app.route("/register", methods=["POST"])
def register():

    data = request.get_json()

    username = data.get("username")

    return jsonify({
        "message": "User Registered Successfully",
        "user": username
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=PORT)