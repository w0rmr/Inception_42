FROM debian:bullseye

RUN apt-get update -y  && apt install ssh python3 -y

COPY files files

COPY setup.sh setup.sh

RUN chmod +x setup.sh 

CMD ["./setup.sh"]
