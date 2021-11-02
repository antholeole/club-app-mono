import requests
import time
import os

ENDPOINT = 'http://localhost:8080'
ADMIN_SECRET = os.environ['HASURA_ADMIN_SECRET']
ALLOWED_QUERIES = 'allowed-queries'

MAX_PINGS = 20
PING_INTERVAL = 5

# wait for the server to be up, if we just did a migration....
print(f'attempting connection to {ENDPOINT}')
current_pings = 0
while True:
    print('ping...')

    response = requests.get(f'{ENDPOINT}/healthz')

    if not response.ok:    
        time.sleep(PING_INTERVAL)
        current_pings = current_pings + 1

        if current_pings > MAX_PINGS:
            raise Exception(f'server couldn\'t be reached in {MAX_PINGS * PING_INTERVAL}s.')

    else:
        print('connection is healthy.')
        break

def remove_from_allow_list(name: str):
    response = requests.post(f'{ENDPOINT}/v1/query', json = {
        "type": "drop_query_from_collection",
        "args": {
            "collection_name": ALLOWED_QUERIES,
            "query_name": name
        }
    }, headers={
        'x-hasura-admin-secret': ADMIN_SECRET
    })

    existed = response.content.decode('UTF-8').find('not found in collection') == -1
    
    if not response.ok and existed:
        raise Exception(response.content)

    return existed

def add_to_allow_list(name: str, query: str):
    response = requests.post(f'{ENDPOINT}/v1/query', json = {
        "type": "add_query_to_collection",
        "args": {
            "collection_name": ALLOWED_QUERIES,
            "query_name": name,
            "query": query
        }
    }, headers={
        'x-hasura-admin-secret': ADMIN_SECRET
    })
    
    if not response.ok:
        raise Exception(response.content)


QUERIES_PATH = '../fe/lib/gql'
for file_name in os.listdir(QUERIES_PATH):
    if file_name.endswith('.graphql'):
        query_name = file_name[:len('.graphql') * -1]

        print(f'processing {query_name}...')
        existed = remove_from_allow_list(query_name)    
        with open(f'{QUERIES_PATH}/{file_name}', 'r') as query_file:
            query = query_file.read()
            add_to_allow_list(query_name, query.replace('\n', '').replace('\t', ''))
        print(f'processed {query_name}. (existed: {existed})')
