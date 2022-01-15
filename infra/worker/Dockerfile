FROM node:17

WORKDIR /app
COPY package.json ./

RUN npm install

COPY . /app
COPY entrypoint.sh /entrypoint.sh

EXPOSE 8787
EXPOSE 9229

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh", "npm", "run", "dev"]