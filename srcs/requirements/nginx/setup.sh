#!/bin/bash

# Create SSL directory
mkdir -p /etc/nginx/ssl

# Generate self-signed SSL certificate and private key
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx-selfsigned.crt -subj "/CN=localhost"

# Generate Diffie-Hellman parameters
openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048

# Set permissions
#chmod 600 /etc/nginx/ssl/*
# Start Nginx
nginx -g 'daemon off;'
