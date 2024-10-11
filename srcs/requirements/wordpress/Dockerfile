FROM debian:bullseye
RUN apt-get -y update && apt-get install -y \
    php-fpm tar curl php-mysqli php-redis 
COPY setup.sh setup.sh
#EXPOSE 9000
# COPY test.sh test.sh
# COPY secret.txt secret.txt
# COPY wp-config.php wp-config.php
RUN chmod +x setup.sh
CMD ["./setup.sh"]
