FROM debian:bullseye

RUN apt-get -y update && apt-get install -y vsftpd openssl

COPY setup.sh setup.sh

RUN chmod +x setup.sh

CMD ["./setup.sh"]

 #CMD ["tail","-f","/dev/null"]
