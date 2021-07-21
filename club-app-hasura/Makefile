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