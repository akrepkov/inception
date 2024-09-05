#!/bin/bash

mkdir -p /var/www/html
chmod 755 /var/www/html
cd /var/www/html
# rm -rf *

#download (WordPress Command Line Interface) 
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar 

# Move WP_CLI to /bin, so it can be run from anywhere on the system using the command wp.
mv wp-cli.phar /usr/local/bin/wp
# wp core download --allow-root

# mkdir -p /home/$USER/data/wordpress
# until mysql -u$MARIADB_USER -p$MARIADB_PASSWORD -h$MARIADB_HOST -e "SHOW DATABASES;" > /dev/null 2>&1; do
#   echo "Waiting for MariaDB to be ready..."
#   sleep 5
# done


# The wp-config.php file is a critical configuration file in WordPress. It contains settings for connecting to the database, security keys, and other important configurations.

if [ ! -f ./wp-config.php ]; then 

	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress
# When WordPress is downloaded, it comes with a sample configuration file named wp-config-sample.php. You need to rename this file to wp-config.php and edit it to include your specific database and site settings.
	mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
	sed -i "s/database_name_here/${MARIADB_DATABASE}/1"   wp-config.php
	sed -i "s/username_here/${MARIADB_USER}/1"  wp-config.php
	sed -i "s/password_here/${MARIADB_PASSWORD}/1"    wp-config.php
	sed -i "s/localhost/${MARIADB_HOST}/g" wp-config.php
	chown www-data:www-data wp-config.php
	chmod 644 /var/www/html/wp-config.php
	# The /1 at the end of the sed command is a modifier that specifies that only the first occurrence of the pattern in each line should be replaced.

	# installs WordPress and sets up the basic configuration for the site. The --url option specifies the URL of the site, --title sets the site's title, --admin_user and --admin_password set the username and password for the site's administrator account, and --admin_email sets the email address for the administrator. The --skip-email flag prevents WP-CLI from sending an email to the administrator with the login details.
	wp core install --url=$DOMAIN_NAME/ --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
fi
# creates a new user account with the specified username, email address, and password. The --role option sets the user's role to author, which gives the user the ability to publish and manage their own posts.
# wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

# installs the Astra theme and activates it for the site. The --activate flag tells WP-CLI to make the theme the active theme for the site.
# wp theme install astra --activate --allow-root


# wp plugin install redis-cache --activate --allow-root


# uses the sed command to modify the www.conf file in the /etc/php/7.3/fpm/pool.d directory. The s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g command substitutes the value 9000 for /run/php/php7.3-fpm.sock throughout the file. This changes the socket that PHP-FPM listens on from a Unix domain socket to a TCP port.
# sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf

# creates the /run/php directory, which is used by PHP-FPM to store Unix domain sockets.
# mkdir -p /run/php


# wp redis enable --allow-root


# starts the PHP-FPM service in the foreground. The -F flag tells PHP-FPM to run in the foreground, rather than as a daemon in the background.
/usr/sbin/php-fpm8.2 -F

# https://github.com/llescure/42_Inception?tab=readme-ov-file


# START WRITINg blog in medium