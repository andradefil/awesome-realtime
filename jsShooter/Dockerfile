FROM node:latest

WORKDIR /tmp
COPY package* /tmp/
RUN npm install

WORKDIR /app
COPY /tmp/* /app

ENV PORT=8080

CMD node app.js