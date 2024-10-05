# Utilizza una versione LTS di Node.js come immagine base
#FROM node:14
#FROM node:lts-bookworm
FROM node:20.18.0-bullseye-slim

# Crea una directory di lavoro nel container
WORKDIR /usr/src/app

# Copia i file package.json e package-lock.json
COPY package*.json ./
COPY server.js ./

RUN npm install -g fastify@v4.28.1
#RUN npm install -g fastify

RUN npm i @fastify/cors

# Installa le dipendenze
RUN npm install

# Copia tutti gli altri file sorgente nel container
#COPY . .

# Espone la porta 3000 (la porta su cui il nostro server Fastify sta ascoltando)
EXPOSE 3000

# Comando da eseguire quando il container viene avviato
CMD ["node", "server.js"]
