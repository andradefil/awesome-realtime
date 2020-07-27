FROM node:latest

WORKDIR /tmp
COPY package* /tmp/
RUN npm install

COPY . /app
WORKDIR /app

ENV PORT=8080
CMD node app.js