run:
	concurrently -c "#800080.bold,#ffa500.bold" -n "BACKEND,HASURA" --handle-input "cd club-app-be && npm run dev" "cd club-app-hasura && make run"

i: 
	(cd fe && flutter pub get && make generate) && \
	(cd club-app-be && (cd club-app-worker && npm i) && (cd club-app-ws && npm i)) && (cd site && npm i) && npm i -g concurrently && \
	npm install -g @dollarshaveclub/cloudworker && (python3 -m venv club-app-hasura/scripts/env&& source club-app-hasura/scripts/env/bin/activate && python3 -m pip install -r club-app-hasura/scripts/requirements.txt) && \
	(brew install hasura-cli) && (npm i -g get-graphql-schema)
