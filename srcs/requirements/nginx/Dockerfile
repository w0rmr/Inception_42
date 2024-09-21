FROM debian:latest

WORKDIR /etc/nginx/


EXPOSE 443 88
RUN apt-get update && apt-get upgrade && apt-get install -y nginx openssl

COPY conf nginx.conf

COPY setup.sh setup.sh

COPY index.html /var/www/html/index.html

RUN chmod +x setup.sh

CMD ["./setup.sh"]

#CMD ["tail","-f","/dev/null"]
