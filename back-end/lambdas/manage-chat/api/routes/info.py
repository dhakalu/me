from flask import Blueprint, request, jsonify

info_api = Blueprint('info_api', __name__)


@info_api.route("/")
def general_info():
    return jsonify(api='manage-chat', app='me', version='1.0')
