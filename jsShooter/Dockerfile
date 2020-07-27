FROM node:latest
COPY package* /tmp/
WORKDIR /tmp
RUN npm install

COPY . /app
WORKDIR /app

ENV PORT=8080

ENTRYPOINT [ "node", "app.js" ]