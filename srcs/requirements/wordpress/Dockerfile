FROM debian:bullseye
RUN apt-get -y update && apt-get install -y \
    php-fpm tar curl php-mysqli php-redis 
COPY setup.sh setup.sh
RUN chmod +x setup.sh
CMD ["./setup.sh"]
