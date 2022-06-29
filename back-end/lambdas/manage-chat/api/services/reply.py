def get_intent(utterances):
    """
    Given the user utterance, returns the intent of the user
    """
    print(utterances)
    return None


def get_reply(intent):
    """
    Given the intent of an user, returns the appropriate response for that intent.
    """
    if intent is None:
        return "Oops! I cannot understand that."
    else:
        # todo read response from dynamo and send it to user
        return intent
