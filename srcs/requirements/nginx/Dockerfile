FROM debian:latest

RUN apt-get update &&  apt-get install -y nginx  openssl

WORKDIR /etc/nginx/

COPY tools/conf /etc/nginx/sites-available/default
COPY tools/index.html /var/www/html/index.html
COPY tools/setup.sh setup.sh

#RUN bash /tmp/setup.sh
RUN chmod +x ./setup.sh

EXPOSE 80 80
EXPOSE 443 443

CMD ["./setup.sh"]
# CMD ["tail", "-f", "/dev/null"]
