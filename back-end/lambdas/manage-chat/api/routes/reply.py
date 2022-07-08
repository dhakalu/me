from flask import Blueprint, request, jsonify
from api.services.reply import ChatService

response_api = Blueprint('response_api', __name__, url_prefix='/responses')

service = ChatService()


@response_api.route('/')
def get_response():
    args = request.args
    query = args.get("q")
    intent = service.get_intent(query)
    reply = service.get_reply(intent)
    return jsonify(question=query, response=reply)
