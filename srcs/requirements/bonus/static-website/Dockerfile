FROM debian:bullseye

RUN apt update -y  && apt install ssh python3 vim -y \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY files files

COPY setup.sh setup.sh

RUN chmod +x setup.sh 

ENTRYPOINT ["./setup.sh"]
CMD ["python3","-m","http.server"]
