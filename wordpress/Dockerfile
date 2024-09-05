FROM debian:bookworm

# Install required packages and clean up after
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends ca-certificates \
    wget php8.2 curl php-fpm php-mysql php-curl net-tools\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create necessary directories
RUN mkdir -p /run/php/ /var/www/ /var/www/html /home/${USER}/data/wordpress

# Copy setup script and make it executable
COPY setup.sh /tmp/
RUN chmod +x /tmp/setup.sh

EXPOSE 9000
# Set up the entry point to the setup script
ENTRYPOINT ["/tmp/setup.sh"]


