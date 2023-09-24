FROM nginx:alpine

RUN apk add --no-cache git gcc libc-dev make openssl-dev pcre-dev zlib-dev linux-headers curl gnupg libxslt-dev gd-dev geoip-dev perl-dev libedit-dev \
    && wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" \
    && git clone https://github.com/openresty/redis2-nginx-module.git \
    && tar -xzvf nginx-${NGINX_VERSION}.tar.gz \
    && cd nginx-${NGINX_VERSION} \
    && ./configure --with-compat --add-dynamic-module=../redis2-nginx-module \
    && make modules \
    && cp objs/ngx_http_redis_module.so /etc/nginx/modules/

EXPOSE 80

