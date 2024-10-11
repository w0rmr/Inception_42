#!/bin/bash

echo -e "Creating new user..."
useradd -r mysql_user -U -M -d /var/lib/mysql

echo -e "Restarting MySQL..."
echo "Configuring MariaDB to listen on port 3306"
echo "[mysqld]" >> /etc/mysql/my.cnf
echo "port = 3306" >> /etc/mysql/my.cnf
echo "bind-address = mariadb" >> /etc/mysql/my.cnf

echo -e "Creating necessary directories..."
mkdir -p /run/mysqld
mkdir -p /var/www/db

echo -e "Setting permissions for MySQL..."
chown -R mysql:mysql /run/mysqld

echo -e "Starting MySQL..."
sudo -u mysql_user service mysql start --skip-networking

echo -e "Waiting for MySQL to start..."
until sudo -u mysql_user mysqladmin ping --silent; do
    echo "MySQL is not ready yet, waiting..."
    sleep 1
done

echo -e "MySQL is ready."

RESULT=`su mysql_user mysqld -u$DB_USER -p$DB_PASSWORD -e "SHOW DATABASES" | grep $DB_NAME`
if [ "$RESULT" == "$DB_NAME" ]; then
    echo "Database exist"
else
    echo "Database does not exist"
    echo -e "Creating SQL initialization script..."
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" > /tmp/init.sql
    echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" >> /tmp/init.sql
    echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD' ;" >> /tmp/init.sql
    echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;" >> /tmp/init.sql
    echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;" >> /tmp/init.sql
    echo "FLUSH PRIVILEGES;" >> /tmp/init.sql
    echo -e "Applying SQL commands..."
    sudo -u mysql_user mysql < /tmp/init.sql

    if [ $? -eq 0 ]; then
        echo -e "SQL commands applied successfully."
    else
        echo "Failed to apply SQL commands."
        exit 1
    fi
fi

echo -e "Stopping MySQL..."
pkill mysqld

echo -e "Restarting MySQL..."
sudo -u mysql_user mysqld &