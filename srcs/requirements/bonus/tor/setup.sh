#!/bin/bash

# Install tor package if not already installed
if ! command -v tor &> /dev/null
then
	apt-get update
	apt-get install -y tor
fi

cp /etc/tor/torrc /etc/tor/backup.torrc

echo "
HiddenServiceDir /var/lib/tor/hidden_service/
HiddenServicePort 80 website:8000
HiddenServicePort $SSH_PORT website:$SSH_PORT
" >> /etc/tor/torrc

tor & 
while [ ! -f "/var/lib/tor/hidden_service/hostname" ]; do 
	echo -e "waiting .. ! "
	sleep 1
done
 cat -e /var/lib/tor/hidden_service/hostname | awk '{print " \033[31myour hostname is \033[32m" $0 "\033[0m"}'

pkill tor
tor
