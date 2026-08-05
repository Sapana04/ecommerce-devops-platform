from flask import Flask, jsonify

app = Flask(__name__)

PORT = 3002


@app.route("/")
def home():
    return jsonify({
        "service": "Product Service",
        "version": "1.0.0",
        "status": "Running"
    })


@app.route("/health")
def health():
    return jsonify({
        "status": "UP"
    })


@app.route("/products")
def products():
    return jsonify([
        {
            "id": 1,
            "name": "Laptop",
            "price": 50000
        },
        {
            "id": 2,
            "name": "Mobile",
            "price": 20000
        }
    ])


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=PORT)