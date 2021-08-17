run:
	concurrently -c "#800080.bold,#ffa500.bold" -n "BACKEND,HASURA" --handle-input "cd infra && npm run dev" "cd hasura && make run"

i: 
	(cd fe && flutter pub get && make generate) && \
	(cd infra && (cd worker && npm i) && (cd infra-mocks/ws-api-gateway && npm i)) && (cd site && npm i) && npm i -g concurrently && \
	npm install -g @dollarshaveclub/cloudworker && (python3 -m venv hasura/scripts/env&& source hasura/scripts/env/bin/activate && python3 -m pip install -r hasura/scripts/requirements.txt) && \
	(brew install hasura-cli) && (npm i -g get-graphql-schema)
