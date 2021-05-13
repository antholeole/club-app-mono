from urllib3.util.retry import Retry
from requests.adapters import HTTPAdapter

import pytest
import requests
import json
import os

API_URL = 'http://localhost:8080/v1/query'

pytest_plugins = ["docker_compose"]

HEALTH_URL = 'http://localhost:8080/healthz'

def pytest_sessionstart(session):
    pass

@pytest.fixture(autouse=True)
def clean_db(session_scoped_container_getter):
    """assert that the docker container is (still) up, and then clear everything after the test"""
    request_session = requests.Session()
    retries = Retry(total=5,
                    backoff_factor=0.1,
                    status_forcelist=[500, 502, 503, 504])
    request_session.mount('http://', HTTPAdapter(max_retries=retries))

    assert request_session.get(HEALTH_URL).status_code == 200

    yield

    with open('../sql_statements/fake_data.sql', 'r') as file:
        sql_string = file.read()
        requests.post(API_URL, data=json.dumps({
            "type": "run_sql",
            "args": {
                "sql": sql_string
            }
        }), headers={
            'X-Hasura-Admin-Secret': os.environ['ADMIN_SECRET']
        })
    print('CLEARED')