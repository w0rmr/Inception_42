FROM debian:bullseye

RUN  echo "deb https://deb.torproject.org/torproject.org bullseye main" | tee -a /etc/apt/sources.list \
    && echo "deb-src https://deb.torproject.org/torproject.org bullseye main" | tee -a /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y procps tor

COPY setup.sh setup.sh
RUN chmod +x setup.sh
CMD ["./setup.sh"]