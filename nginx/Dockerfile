# Usa l'immagine ufficiale di OpenResty come base
#FROM openresty/openresty:1.25.3.2-alpine-apk
FROM openresty/openresty:latest

# Installa le dipendenze e luarocks
RUN apt-get update && \
    apt-get install -y wget unzip build-essential libreadline-dev && \
    wget https://luarocks.org/releases/luarocks-3.7.0.tar.gz && \
    tar zxpf luarocks-3.7.0.tar.gz && \
    cd luarocks-3.7.0 && \
    ./configure --with-lua=/usr/local/openresty/luajit \
        --with-lua-include=/usr/local/openresty/luajit/include/luajit-2.1 && \
    make && make install && \
    cd .. && rm -rf luarocks-3.7.0*

# Installa il modulo Lua Redis
RUN luarocks install lua-resty-redis

# Copia il tuo script Lua e la configurazione NGINX nel container
COPY ./redis.lua /etc/nginx/redis.lua
COPY ./redis.conf /etc/nginx/conf.d/default.conf

# Espone la porta standard di NGINX
EXPOSE 80

# Avvia OpenResty
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
