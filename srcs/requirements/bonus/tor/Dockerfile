FROM debian:bullseye

RUN apt-get update 

COPY setup.sh setup.sh

RUN chmod +x setup.sh

CMD ["./setup.sh"]
# CMD ["tail","-f","/dev/null"]