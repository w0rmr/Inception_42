#!/bin/bash

if [ -f "/etc/tor/backup.torrc" ]; then 
    echo "Backup configuration exists."
else
    cp /etc/tor/torrc /etc/tor/backup.torrc
    echo "
    HiddenServiceDir /var/lib/tor/myservice/
    HiddenServicePort 80 website:8000
    HiddenServicePort $SSH_PORT website:$SSH_PORT
    " >> /etc/tor/torrc
fi

echo "Starting Tor service..."
tor &

while [ ! -f "/var/lib/tor/myservice/hostname" ]; do 
    echo -e "Waiting for hostname file..."
    sleep 1
done

cat /var/lib/tor/myservice/hostname | awk '{print " \033[31mYour hostname is \033[32m" $0 "\033[0m"}'
pkill tor


exec tor