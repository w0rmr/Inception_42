#!/bin/bash

# Create SSL directory
mkdir -p /etc/nginx/ssl

# Generate Certificate Authority (CA)
openssl genrsa -out /etc/nginx/ssl/myCA.key 2048
openssl req -x509 -new -nodes -key /etc/nginx/ssl/myCA.key -sha256 -days 1024 -out /etc/nginx/ssl/myCA.pem -subj "/CN=My Local CA"

# Generate self-signed SSL certificate and private key for Nginx
openssl genrsa -out /etc/nginx/ssl/nginx-selfsigned.key 2048
openssl req -new -key /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx.csr -subj "/CN=$DOMAIN_NAME"

# Sign the certificate with the local CA
openssl x509 -req -in /etc/nginx/ssl/nginx.csr -CA /etc/nginx/ssl/myCA.pem -CAkey /etc/nginx/ssl/myCA.key -CAcreateserial -out /etc/nginx/ssl/nginx-selfsigned.crt -days 365 -sha256

echo "Generating Diffie-Hellman parameters..."
openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048 -quiet
echo "Done!"

# Set permissions
chmod 600 /etc/nginx/ssl/*

# Start Nginx
echo "Starting Nginx..."
nginx -g 'daemon off;'
echo "Done!"
