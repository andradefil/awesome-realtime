FROM node:latest
COPY package* /tmp/
WORKDIR /tmp
RUN npm install

WORKDIR /app
COPY . /app

ENV PORT=80

ENTRYPOINT [ "node", "app.js" ]