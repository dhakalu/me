from ensurepip import version
from flask import Flask, jsonify, make_response, request
from api.routes.reply import response_api
from api.routes.info import info_api
app = Flask(__name__)

app.register_blueprint(response_api)
app.register_blueprint(info_api)


@app.errorhandler(404)
def resource_not_found():
    return make_response(jsonify(error='The api does not exist for this path'), 404)
