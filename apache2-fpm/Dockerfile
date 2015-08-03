FROM gauravgoyal/ubuntu:sources

# Specifying the maintainer for this image.
MAINTAINER Gaurav Goyal "gkg.ras@gmail.com"

# All commands ran in this file must be non interactive.
ENV DEBIAN_FRONTEND noninteractive

# Install Apache mpm worker with php5-fpm
RUN apt-get install -y apache2-mpm-worker libapache2-mod-fastcgi php5-fpm php5-mysql mysql-client php5-gd php5-curl curl php5-cli php5-memcached

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Install Drush 7.
RUN composer global require drush/drush
RUN composer global update

# Unfortunately, adding the composer vendor dir to the PATH doesn't seem to work. So:
RUN ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush

# Enable apache default server configuration
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf
RUN a2enconf servername

# Enable apache2 modules
RUN a2enmod actions fastcgi rewrite alias

#ENV Vars
ENV APACHE_RUN_USER  	www-data
ENV APACHE_RUN_GROUP 	www-data
ENV APACHE_LOG_DIR   	/var/log/apache2
ENV APACHE_PID_FILE    	/var/run/apache2.pid
ENV APACHE_RUN_DIR     	/var/run/apache2
ENV APACHE_LOCK_DIR    	/var/lock/apache2

# Add php5-conf file
ADD php5-fpm.conf /etc/apache2/conf-available/php5-fpm.conf

# Enable php5-fpm conf
RUN a2enconf php5-fpm.conf

# Some php5-fpm common changes
RUN sed -i 's/;listen = \/var\/run\/php5-fpm.sock/listen = \/var\/run\/php5-fpm.sock/' /etc/php5/fpm/pool.d/www.conf && sed -i 's/\;listen.mode/listen.mode/' /etc/php5/fpm/pool.d/www.conf && sed -i 's/expose_php.*/expose_php = off/g' /etc/php5/fpm/php.ini && sed -i 's/allow_url_fopen.*/allow_url_fopen = off/g' /etc/php5/fpm/php.ini

# Open SSH server configurations
ENV AUTHORIZED_KEYS **None**
ADD ssh/root_pw_set.sh /root_pw_set.sh
ADD ssh/configure.sh /configure.sh
RUN chmod +x /*.sh

# Expose port 80 for apache && 22 for ssh server.
EXPOSE 80 22

# start apache2
CMD ["/configure.sh"]
