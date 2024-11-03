#!bin/bash

wget  --no-check-certificate "http://www.adminer.org/latest.php"
mkdir -p /var/www/html
rm -rf /var/www/html/*

mv latest.php /var/www/html/index.php

cd /var/www/html

exec php -S 0.0.0.0:80
