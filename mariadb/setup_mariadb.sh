#!/bin/bash

# if sudo lsof -i :3306 >/dev/null 2>&1; then
#     sudo mysqladmin shutdown
# fi
cat <<EOF > /etc/mysql/mariadb.conf.d/50-server.cnf
[mysqld]
user = mysql
bind-address = 0.0.0.0
datadir = /var/lib/mysql
pid-file = /var/run/mysqld/mysqld.pid
socket = /var/run/mysqld/mysqld.sock
port = 3306
symbolic-links = 0
basedir = /usr
EOF
mkdir -p /var/run/mysqld /var/lib/mysql
mkdir -p /home/$USER/data/mariadb
chown -R mysql:mysql /var/run/mysqld /var/lib/mysql
#The -R flag in the chown command stands for "recursive."
#It tells chown to make changes in the directory and all of its contents.
#-u user; -p password
if [ ! -d "/var/lib/mysql/${MARIADB_DATABASE}" ]; then
	until mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "SELECT 1" > /dev/null 2>&1; do
		echo "Loading MariaDB..."
		sleep 5
	done
    mysql -u root -p"${MARIADB_ROOT_PASSWORD}"<<EOF
    CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
    GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
    FLUSH PRIVILEGES;
EOF
fi

# Indicate that setup is complete
echo "MariaDB setup complete."
service mariadb stop
# Keep the container running by starting MariaDB as the main process
exec mysqld_safe