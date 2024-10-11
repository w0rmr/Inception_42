FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y redis-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
COPY setup.sh setup.sh

RUN chmod +x setup.sh

CMD ["./setup.sh"]