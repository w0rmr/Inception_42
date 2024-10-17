#!/bin/bash

echo "deb https://deb.torproject.org/torproject.org bullseye main" | tee -a /etc/apt/sources.list
echo "deb-src https://deb.torproject.org/torproject.org bullseye main" | tee -a /etc/apt/sources.list

apt install curl gnupg2 -y

curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -
apt install tor -y

cp /etc/tor/torrc /etc/tor/backup.torrc

echo "
HiddenServiceDir /var/lib/tor/hidden_service/
HiddenServicePort 80 website:8000
HiddenServicePort $SSH_PORT website:$SSH_PORT
" >> /etc/tor/torrc
tor