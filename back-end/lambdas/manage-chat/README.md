# Manage Chat

[![serverless](http://public.serverless.com/badges/v3.svg)](http://www.serverless.com)

This repo contains the code for powering manage-chat service. This service create REST APIs for needed for _chat_ feature of _me_ app.

## Local Development

- Create virtual environment to run this project

```sh
    python3.8 -m venv ./venv
    source ./venv/bin/activate
```

- Download and install required packages:

```sh
pip install werkzeug
pip install -r requirements.txt
```

- Run:

```sh
    serverless wsgi serve
```
