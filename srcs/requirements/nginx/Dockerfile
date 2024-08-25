FROM debian:latest



RUN apt-get update && sudo apt-get install -y nginx 

WORKDIR /etc/nginx/

COPY conf nginx.conf

RUN  systemctl restart nginx
