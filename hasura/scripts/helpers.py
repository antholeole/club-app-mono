import requests
import json  

API_URL = 'http://localhost:8080/v1/query'
ADMIN_KEY = 'aodrkofkioermwieojrowiemfosdmfiosdmfisdmfiosdmfiosmaoisaosidmoi'

def build_req(query: str) -> str:
    return json.dumps({
    "type": "run_sql",
    "args": {
        "sql": query
    }
    })

def send_query_from_file(filename: str) -> requests.Response:
    with open(f'sql_statements/{filename}','r') as file:
        sql_string = file.read()
        return requests.post(API_URL, data = build_req(sql_string), headers = {
            'X-Hasura-Admin-Secret': ADMIN_KEY
        })