club-app monorepo.

## Dev

Note: Can run each individually. No need to run all if not required

### Presequites
- Docker (docker-compose)
- concurrently (`npm i -g concurrently`)

to run, `make run`. first run will take a minute so grab a drink :)
This will boot up:
- Cloudflare worker
- API Gateway
- Hasura Docker Container

## TESTS

### Hasura
Docker container must be up 

all ACL to Hasura must be tested - this is because allowing a user to do something that they shouldn't be could be catastrophic. 

ex. test that a user CAN change his own name BUT not anyone elses.

## Todo

Everything, but currently:
- https://mockuphone.com/device/iphone12blue for site
- Need to create seed data
- Event subscriptions
- Pull seed data on load in
- use ISAR to Persist Data

## CICD
worker:
- test

Hasura:
- test

flutter:
- pub run dependency_validator
- take queries and add them to the allow list in hasura
- lint
- test

next:
- build, put in worker pages deploy and deploy