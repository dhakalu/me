from flask import Blueprint, request, jsonify
from api.services.reply import get_intent, get_reply

response_api = Blueprint('response_api', __name__, url_prefix='/responses')


@response_api.route('/')
def get_response():
    args = request.args
    query = args.get("q")
    intent = get_intent(query)
    reply = get_reply(intent)
    return jsonify(question=query, response=reply)
