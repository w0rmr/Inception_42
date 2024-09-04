#!/bin/bash

# Create the directory for SSL certificates
mkdir -p /etc/nginx/ssl

# Generate a self-signed SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx-selfsigned.crt -subj "/CN=localhost"

# Generate Diffie-Hellman parameters
openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048

# Set permissions
chmod 600 /etc/nginx/ssl/*

# Create symbolic link if it doesn't exist
if [ ! -L /etc/nginx/sites-enabled/default ]; then
    ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
fi

# Start Nginx
nginx -g "daemon off;"