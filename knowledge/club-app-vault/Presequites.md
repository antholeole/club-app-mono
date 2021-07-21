# Presequites
You will need these to run the application in any capacity.
- Brew for installing these presequites on MacOS
	- `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
- [Docker](https://www.docker.com/) to run the Hasura Container
-  Node  Most of the projects are NPM projects. NEED NODE 14 FOR cloudworker!
	-  `brew install node@14`
- Concurrently to be able to run entire sections of the app concurrently
	- `npm i -g concurrently`
