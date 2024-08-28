FROM debian:bookworm 
#change
COPY ./setup_mariadb.sh /docker-entrypoint-initdb.d/

RUN apt-get update && apt-get install -y mariadb-client && \
	chmod +x docker-entrypoint-initdb.d/setup_mariadb.sh


# Expose the default MariaDB port
EXPOSE 3306
# Make sure the entrypoint script runs the setup script after initialization
ENTRYPOINT ["docker-entrypoint-initdb.d/setup_mariadb.sh"]
