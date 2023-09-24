# Utilizza un'immagine base di Node.js
FROM node:14

# Crea una directory di lavoro nel container
WORKDIR /usr/src/app

# Copia i file package.json e package-lock.json
COPY package*.json ./

# Installa le dipendenze
RUN npm install

# Copia tutti gli altri file sorgente nel container
COPY . .

# Espone la porta 8080 (o la porta su cui il tuo frontend sta ascoltando)
EXPOSE 8080

# Comando da eseguire quando il container viene avviato (ad es. per un'app Vue.js o React.js)
CMD ["npm", "run", "serve"]

