FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive
#debconf is the configuration management system used by Debian packages to interact with users during package installation. 
# It supports various interfaces (e.g., Dialog, Readline, Teletype)
# In Docker containers, where there's no terminal, so debconf fails to initialize them
COPY ./setup_mariadb.sh /docker-entrypoint-initdb.d/

RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-client mariadb-server apt-utils && \
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