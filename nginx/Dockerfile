# Use the official OpenResty image as base
FROM openresty/openresty:1.25.3.2-0-bullseye

# lua-resty-redis is included with OpenResty by default, no need to install via luarocks

# Copy the Lua script and the NGINX configuration in the container
COPY ./redis.lua /etc/nginx/redis.lua
COPY ./redis.conf /etc/nginx/conf.d/default.conf

# Expose the standard NGINX port
EXPOSE 80

# Start OpenResty
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
