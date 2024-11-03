#!/bin/bash


mkdir -p /etc/nginx/ssl


openssl genrsa -out /etc/nginx/ssl/myCA.key 2048
openssl req -x509 -new -nodes -key /etc/nginx/ssl/myCA.key -sha256 -days 1024 -out /etc/nginx/ssl/myCA.pem -subj "/CN=My Local CA"

openssl genrsa -out /etc/nginx/ssl/nginx-selfsigned.key 2048
openssl req -new -key /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx.csr -subj "/CN=$DOMAIN_NAME"

openssl x509 -req -in /etc/nginx/ssl/nginx.csr -CA /etc/nginx/ssl/myCA.pem -CAkey /etc/nginx/ssl/myCA.key -CAcreateserial -out /etc/nginx/ssl/nginx-selfsigned.crt -days 365 -sha256

echo "Generating Diffie-Hellman parameters..."
openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048 -quiet
echo "Done!"

chmod 600 /etc/nginx/ssl/*

echo "Starting Nginx..."

echo "Done!"

exec "$@"
