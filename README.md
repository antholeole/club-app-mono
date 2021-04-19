club-app monorepo.

initalized as an NPM directory because NPM makes things easy!

## Dev

Note: Can run each individually. No need to run all if not required

### Presequites
- Docker (docker-compose)
- npm i in all subdirectories (club-app-be ws and worker)
- npm run dev

to run, `npm run dev`. first run will take a minute so grab a drink :)

## TESTS

### Hasura
Docker container must be up 

all ACL to Hasura must be tested - this is because allowing a user to do something that they shouldn't be could be catastrophic. 

ex. test that a user CAN change his own name BUT not anyone elses.

## Todo

Everything, but currently:
- Need to create seed data
- Event subscriptions
- Pull seed data on load in
- use ISAR to Persist Data