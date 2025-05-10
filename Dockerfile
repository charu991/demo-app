FROM node:18-alpine

LABEL maintainer="charugunjan88@gmail.com"

WORKDIR /app

COPY package*.json ./
RUN npm cache clean --force
RUN npm install 

COPY . .

EXPOSE 3000

CMD ["node", "server.js"]

