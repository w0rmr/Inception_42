FROM debian:bullseye

RUN apt-get update && apt-get -y install mariadb-server \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY setup.sh setup.sh
RUN chmod +x setup.sh
ENTRYPOINT ["./setup.sh"]
CMD ["mysqld"]
