#!/bin/bash
echo "Configuring MariaDB to listen on port 3306"
echo "[mysqld]" >> /etc/mysql/my.cnf
echo "port = 3306" >> /etc/mysql/my.cnf
echo "bind-address = 0.0.0.0" >> /etc/mysql/my.cnf

echo "Starting MySQL"
service mariadb start
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

echo "Disallow root login remotely"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '${DB_HOST}', '::1');"

echo "Removing anonymous users"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "DELETE FROM mysql.user WHERE User='';"

echo "Removing the test database if it exists"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "DROP DATABASE IF EXISTS test;"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"

echo "Checking if database exists"
DB_EXISTS=$(mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "SHOW DATABASES LIKE '${DB_NAME}';" | grep ${DB_NAME})

if [ "$DB_EXISTS" = "${DB_NAME}" ]; then
    echo "Database already exists"
else
    echo "Creating database"
    mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE ${DB_NAME} CHARACTER SET ${DB_CHARSET} COLLATE ${DB_CHARSET}_general_ci;"
    echo "Creating WordPress user"
    mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    echo "Granting all privileges on WordPress database to WordPress user"
    mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL ON ${DB_NAME}.* TO '${DB_USER}'@'${DB_HOST}';"

    echo "Flushing privileges to ensure that they take effect"
    mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

    echo "Reloading privilege tables"
    mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"
fi

echo "Ensuring MySQL is running as a daemon"
service mariadb restart