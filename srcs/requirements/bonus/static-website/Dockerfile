FROM debian:bullseye

RUN apt-get update -y 

COPY setup.sh setup.sh

RUN chmod +x setup.sh 

CMD["./setup.sh"]
