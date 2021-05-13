
import pytest
import requests
import json
import jwt
import os

API_URL = 'http://localhost:8080/v1/graphql'
pytest_plugins = ["docker_compose"]


def gql_request(query: str, token: str = None, is_admin: bool = None) -> requests.Response:
    headers = dict()

    if token:
        headers['Authorization'] = f'Bearer {token}'
        headers['x-hasura-role'] = 'user'
    elif is_admin:
        headers['x-hasura-admin-secret'] = os.environ['ADMIN_SECRET']

    return requests.request("POST", API_URL, data=json.dumps({
        'query': query
    }), headers=headers)


def create_user(sub: str, name: str = None) -> str:
    '''
    creates a user and returns his ID.
    '''

    if name:
        name_str = f'name: "{name}"'
    else:
        name_str = ''

    resp = gql_request(f'''
    mutation {{
        insert_users_one(object: {{
            sub: "{sub}"
            {name_str}
            }}) {{
                sub,
                email,
                name
            }}
        }}
    ''', is_admin=True)

    return json.loads(resp.content)


def create_jwt(user_id: str) -> str:
    return jwt.encode({
        'sub': user_id,
        'https://hasura.io/jwt/claims': {
            'x-hasura-allowed-roles': ['user', 'guest'],
            'x-hasura-user-id': user_id,
            'x-hasura-default-role': 'user'
        }
    }, key=os.environ['JWT_SECRET'])
