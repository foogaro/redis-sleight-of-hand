local redis = require "resty.redis"
local red = redis:new()

red:set_timeouts(1000, 1000, 1000) -- 1 sec

-- Connect to Redis
--local ok, err = red:connect('ngx.var.host', 6379)
local ok, err = red:connect('172.32.0.3', 6379)
if not ok then
    ngx.log(ngx.ERR, "Error connecting to Redis: ", err)
    return
end

-- Check if the request has already been processed
local res, err = red:get(ngx.var.request_uri)
if res ~= ngx.null then
    -- If present in cache, return error
    ngx.log(ngx.INFO, "Request already processed by the backend.")
    ngx.status = 409  -- Conflict status code
    ngx.header.content_type = "application/json"
    ngx.print('{"error": "Request already processed by the backend.", "message": "The request has been already processed by the backend."}')
    return
end

-- If not in cache, proceed with the backend
ngx.log(ngx.INFO, "Request can be processed by the backend.")
res = ngx.location.capture("/backend" .. ngx.var.request_uri)

-- If the response is good, save the request (uri).
if res.status == 200 then
    local ok, err = red:set(ngx.var.request_uri, ngx.var.request_uri)
    if not ok then
        ngx.log(ngx.ERR, "Failed to save the request: ", err)
    end
end

-- Send the response to the client
ngx.print(res.body)
