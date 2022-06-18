# Chat Service

This service exposes the functionalities related to chat.

## How does prediction work?

- Docker downloads the the prediction model from s3.
- Flask responds to the user query to `/predict` endpoint.


## Running locally

### Setup

```sh
$ cd <path-to-chat>
$ python3 -m venv venv
$ . venv/bin/activate

$ pip install Flask
```

### Run application

```bash
$ export FLASK_APP=hello
$ flask run
 * Running on http://127.0.0.1:5000/
```
