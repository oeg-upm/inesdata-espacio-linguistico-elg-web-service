# ELG Connector Web Service

This component needs an ELG authentication token, we can create it with the elg python client:

```bash
python3.11 -m venv .venv
source .venv/bin/activate
pip install elg
```
Then we run the following code:
```python
from elg import Authentication

auth = Authentication.init(scope="offline_access")
auth.to_json("tokens.json")
```
This will create the authentification token that will be used by the ELG Connector Web Service.

We can now build the Docker image with:
```bash
docker build -t elg_connector_ws .
```