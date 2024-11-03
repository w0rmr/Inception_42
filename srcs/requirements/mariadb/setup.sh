#! /bin/bash

mkdir -p /run/mysqld
mkdir -p /var/www/db
chown -R mysql:mysql /var/run/mysqld
mysqld &

while ! mysqladmin ping --silent; do
    echo "MySQL is not ready yet, waiting..."
    sleep 1
done

mysql_secure_installation << _EOF_
$MYSQL_ROOT_PASSWORD
n
n
Y
Y
Y
Y
_EOF_
if [ -d "/var/lib/mysql/$DB_NAME" ]; then
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
    mysql < /tmp/init.sql

    if [ $? -eq 0 ]; then
        echo -e "SQL commands applied successfully."
    else
        echo "Failed to apply SQL commands."
        exit 1
    fi
fi

sed -i "s/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf
pkill mysqld

echo -e "Restarting MySQL..."

exec "$@"

