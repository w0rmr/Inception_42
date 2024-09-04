FROM debian:latest

RUN apt-get update && sudo apt-get install -y nginx  openssl

WORKDIR /etc/nginx/

COPY conf conf.d/default.conf

COPY tools/setup.sh /tmp/setup.sh

RUN bash /tmp/setup.sh

CMD ["nginx", "-g", "daemon off;"]
