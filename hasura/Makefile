#runs the hasura container and refreshes all the data by running the faker script.
run: 
	docker compose --env-file ./../.env up 

seed:
	ADMIN_SECRET=$$(grep ADMIN_SECRET ./../.env | cut -d '=' -f 2-) && \
	hasura seed apply --admin-secret "$$ADMIN_SECRET" --database-name default
	
console:
	ADMIN_SECRET=$$(grep ADMIN_SECRET ./../.env | cut -d '=' -f 2-) && \
	hasura console --admin-secret $$ADMIN_SECRET

test:
	docker-compose down && source scripts/env/bin/activate && cd scripts/tests && \
	 JWT_SECRET=$$(grep JWT_SECRET ./../../../.env | cut -d '=' -f 2-) \
	 ADMIN_SECRET=$$(grep ADMIN_SECRET ./../../../.env | cut -d '=' -f 2-) pytest --docker-compose=./../../docker-compose.yaml

whitelist:
	export NODE_OPTIONS= && ADMIN_SECRET=$$(grep ADMIN_SECRET ./../.env | cut -d '=' -f 2-) && \
	export ADMIN_SECRET=$$ADMIN_SECRET && \
	./scripts/env/bin/python3 scripts/allow_list/allow_queries.py && hasura metadata export --admin-secret $$ADMIN_SECRET