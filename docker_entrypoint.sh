#!/bin/sh

printf "\n\n [i] Starting Timechain Calendar ...\n\n"

# 
CONF_FILE="/etc/nginx/conf.d/default.conf"
NGINX_CONF='server {
    listen 80;
    return 301 https://$host$request_uri;
}

server {
    listen 8080;
    listen 3443 ssl;
    http2 on;
    ssl_certificate /mnt/cert/main.cert.pem;
    ssl_certificate_key /mnt/cert/main.key.pem;

    server_name localhost;

    root /usr/share/nginx/html;
    index index.html index.htm;

    # Gzip settings
    gzip on;
    gzip_disable "msie6";
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_buffers 16 8k;
    gzip_http_version 1.1;
    gzip_min_length 256;
    gzip_types
        application/atom+xml
        application/geo+json
        application/javascript
        application/x-javascript
        application/json
        application/ld+json
        application/manifest+json
        application/rdf+xml
        application/rss+xml
        application/xhtml+xml
        application/xml
        font/eot
        font/otf
        font/ttf
        image/svg+xml
        text/css
        text/javascript
        text/plain
        text/xml;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api/v1/ws {
      proxy_pass http://mempool.embassy:8080/api/v1/ws;
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }
}
'
echo "$NGINX_CONF" > $CONF_FILE

_term() {
  echo "Caught SIGTERM signal!"
  kill -SIGTERM "$timechaincalendar_process" 2>/dev/null
}

nginx -g 'daemon off;' &
timechaincalendar_process=$!

trap _term SIGTERM

wait $timechaincalendar_process
