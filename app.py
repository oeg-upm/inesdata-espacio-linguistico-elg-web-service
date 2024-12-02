import requests
from flask import Flask, redirect, abort
from elg import Corpus

app = Flask(__name__)

@app.route("/<string:id>")
def web_service(id):
    corpus = Corpus.from_id(id,auth_file="tokens.json")
    corpus.authentication.refresh_if_needed()
    headers = {"Authorization": f"Bearer {corpus.authentication.access_token}"}
    headers["accept-licence"] = "True"
    headers["filename"] = str(corpus.distributions[0].filename)
    headers["elg-resource-distribution-id"] = str(corpus.distributions[0].pk)
    response = requests.post(
            f"https://live.european-language-grid.eu/catalogue_backend/api/management/download/{corpus.distributions[0].corpus_id}/",
            headers=headers
        )
    if response.ok:
        return redirect(response.json()["s3-url"], code=307)
    else:
        abort(500, f"Something went wrong when calling ELG API, response:{response.text}")