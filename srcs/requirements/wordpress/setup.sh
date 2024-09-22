cd /tmp
apt install -y curl
curl -LO https://wordpress.org/latest.tar.gz
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
cp -a /tmp/wordpress/. /var/www/html
chown -R www-data:www-data /var/www/html

#sudo cp -a /tmp/wordpress/. /var/www/your_domain-y 
