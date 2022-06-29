from ensurepip import version
from flask import Flask, jsonify, make_response, request

app = Flask(__name__)


@app.route("/")
def general_info():
    return jsonify(api='manage-chat', app='me', version='1.0')


@app.route("/response")
def get_response():
    args = request.args
    query = args.get("q")
    return jsonify(question=query, response='Oops! I cannot understand that.')


@app.errorhandler(404)
def resource_not_found(e):
    return make_response(jsonify(error='The api does not exist for this path'), 404)
