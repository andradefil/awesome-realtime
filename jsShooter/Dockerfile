FROM node:latest

COPY package* /app/
WORKDIR /app

RUN npm install
COPY . /app

ENV PORT=8080
CMD node app.js