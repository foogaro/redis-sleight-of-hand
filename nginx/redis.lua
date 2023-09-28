local redis = require "resty.redis"
local red = redis:new()

red:set_timeouts(1000, 1000, 1000) -- 1 sec

-- Connettiti a Redis
local ok, err = red:connect(ngx.var.host, 6379)
if not ok then
    ngx.log(ngx.ERR, "Errore durante la connessione a Redis: ", err)
    return
end

-- Prova a recuperare la risposta dalla cache usando l'URI come chiave
local res, err = red:get(ngx.var.request_uri)
if res ~= ngx.null then
    -- Se presente in cache, servilo
    ngx.log(ngx.INFO, "Prendo il risultato direttamente dalla cache di Redis.")
    ngx.print(res)
    return
end

-- Se non in cache, effettua la richiesta al backend
ngx.log(ngx.INFO, "Richiesta non memorizzata nella cache di Redis.")
res = ngx.location.capture("/backend" .. ngx.var.request_uri)

-- Se la risposta e' buona memorizza la risposta in Redis con un tempo di scadenza di 10 minuti (600 secondi)
if res.status == 200 then
    local ok, err = red:setex(ngx.var.request_uri, 600, res.body)
    if not ok then
        ngx.log(ngx.ERR, "Ops, non è stato possibile memorizare la richiesta nella cache di Redis: ", err)
    end
end

-- Invia la risposta al client
ngx.print(res.body)
