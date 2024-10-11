FROM debian:bullseye

RUN apt update -y && apt install wget -y && apt install php php-mysql  -y

COPY setup.sh setup.sh

RUN chmod +x setup.sh

CMD ["./setup.sh"]
