backend:
	concurrently -c "#800080.bold,#ffa500.bold" -n "BACKEND,HASURA" --handle-input "cd club-app-be && npm run dev" "cd club-app-hasura && make run"