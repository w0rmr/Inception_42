#!/bin/bash

# Install MariaDB
sudo apt-get update
sudo apt-get install -y mariadb-server

# Set environment variables
export DB_NAME="database_name_here"
export DB_USER="username_here"
export DB_PASSWORD="password_here"
export DB_HOST="localhost"
export DB_CHARSET="utf8"
export DB_COLLATE=""

# Secure MariaDB installation
#!/bin/bash

# Set a password for the root user
mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');"

# Disallow root login remotely
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"

# Remove anonymous users
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "DELETE FROM mysql.user WHERE User='';"

# Remove the test database
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "DROP DATABASE test;"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"

# Reload privilege tables
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

echo "MariaDB is now secured."

# Update wp-config.php file
sed -i "s/database_name_here/$DB_NAME/g" wp-config.php
sed -i "s/username_here/$DB_USER/g" wp-config.php
sed -i "s/password_here/$DB_PASSWORD/g" wp-config.php
sed -i "s/localhost/$DB_HOST/g" wp-config.php
sed -i "s/utf8/$DB_CHARSET/g" wp-config.php
sed -i "s/'DB_COLLATE', ''/'DB_COLLATE', '$DB_COLLATE'/g" wp-config.php