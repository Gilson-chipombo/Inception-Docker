#!/bin/bash

# Garantir diretório SSL
mkdir -p /etc/nginx/ssl

# Criar certificado SSL se não existir
if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=AO/ST=Luanda/L=Luanda/O=42/OU=Inception/CN=gbravo-f.42.fr"
fi

# Iniciar NGINX em foreground
nginx -g "daemon off;"