FROM debian:bookworm 

COPY ./setup_mariadb.sh /docker-entrypoint-initdb.d/

RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-client mariadb-server && \
	chmod +x docker-entrypoint-initdb.d/setup_mariadb.sh

EXPOSE 3306

CMD ["/docker-entrypoint-initdb.d/setup_mariadb.sh"]
# Make sure the entrypoint script runs the setup script after initialization
# ENTRYPOINT ["docker-entrypoint-initdb.d/setup_mariadb.sh"]


# I tried to add option file, but got "E: Sub-process /usr/bin/dpkg returned an error code (1)":
# [mysqld]
# user		= mysql
# bind		= 0.0.0.0
# datadir		= /var/lib/mysql
# pid-file	= /var/run/mysqld/mysqld.pid
# socket		= /var/run/mysqld/mysqld.sock
# port		= 3306
# symbolic-links = 0
# basedir		= /usr
# Instead I added it in the script