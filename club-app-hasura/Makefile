#runs the hasura container and refreshes all the data by running the faker script.
run: 
	(while ! echo exit | nc localhost 8080; do sleep 10; done && \
	source scripts/env/bin/activate && \
	sleep 4 && \
	 (cd scripts && python3 faker.py -c)) & docker compose --env-file ./../.env up 
	
console:
	ADMIN_SECRET=$$(grep ADMIN_SECRET ./../.env | cut -d '=' -f 2-) && \
	hasura console --admin-secret $$ADMIN_SECRET

test:
	docker-compose down && source scripts/env/bin/activate && cd scripts/tests && \
	 JWT_SECRET=$$(grep JWT_SECRET ./../../../.env | cut -d '=' -f 2-) \
	 ADMIN_SECRET=$$(grep ADMIN_SECRET ./../../../.env | cut -d '=' -f 2-) pytest --docker-compose=./../../docker-compose.yaml