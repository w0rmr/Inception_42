#!/bin/bash


mkdir -p /run/php

if [ -f "/var/www/html/wp-config.php" ]; then
    echo "Wordpress is already installed"
else
    echo "Wordpress is not installed"
    mkdir -p /var/www/html
    rm -rf /var/www/html/*
    cd tmp
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    wp core download --path=/var/www/html --allow-root


    cd /var/www/html

    mv wp-config-sample.php wp-config.php
    # wp plugin deactivate --all --allow-root
    # wp theme install astra --activate --allow-root
    # wp theme activate astra --allow-root

    wp config set DB_NAME $DB_NAME  --allow-root
    wp config set DB_USER $DB_USER  --allow-root
    wp config set DB_PASSWORD $DB_PASSWORD  --allow-root
    wp config set DB_HOST $DB_HOST  --allow-root
    wp config set DB_CHARSET $DB_CHARSET --allow-root
    wp config set WP_REDIS_HOST "redis" --allow-root
    wp config set WP_REDIS_PORT 6379 --allow-root
    wp config set WP_HOME $DOMAIN_NAME --allow-root
    # wp config set WP_SITEURL $DOMAIN_NAME  --allow-root
    #wp plugin install redis-cache --activate --allow-root
    #wp redis enable --allow-root
    # wp config set DB_COLLATE $DB_COLLATE --allow-root
    wp config shuffle-salts --allow-root
    
    echo "Keys and salts have been successfully generated and inserted into wp-config.php"

    wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_EMAIL --skip-email  --allow-root
    wp user create $WP_USER dummy@example.com --role=author --user_pass=$WP_PASS --allow-root
    # --activate --allow-root
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root
    # wp plugin install elementor --activate --allow-root
    # wp plugin update --all --allow-root
    chown -R www-data:www-data /var/www/html/*
    find /var/www/html/ -type d -exec chmod 755 {} \;
    find /var/www/html/ -type f -exec chmod 644 {} \;
fi
sed -i "s/listen = .*/listen = wordpress:9000/g" /etc/php/7.4/fpm/pool.d/www.conf
echo -e "starting php fpm"

exec php-fpm7.4 -F
