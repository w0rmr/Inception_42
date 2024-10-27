FROM debian:bullseye

RUN apt update -y  && apt install ssh python3 vim -y 

COPY files files

COPY setup.sh setup.sh

RUN chmod +x setup.sh 

CMD ["./setup.sh"]
