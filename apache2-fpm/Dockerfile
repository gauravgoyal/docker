FROM gauravgoyal/ubuntu:sources

# Specifying the maintainer for this image.
MAINTAINER Gaurav Goyal "gkg.ras@gmail.com"

# All commands ran in this file must be non interactive.
ENV DEBIAN_FRONTEND noninteractive
ENV BOOT2DOCKER_ID 1000
ENV BOOT2DOCKER_GID 50
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M

RUN usermod -u ${BOOT2DOCKER_ID} www-data && \
    usermod -G staff www-data

RUN groupmod -g $(($BOOT2DOCKER_GID + 10000)) $(getent group $BOOT2DOCKER_GID | cut -d: -f1)
RUN groupmod -g ${BOOT2DOCKER_GID} staff

# Install Apache mpm worker with php5-fpm
RUN apt-get install -y apache2-mpm-worker libapache2-mod-fastcgi php5-fpm php5-mysql mysql-client php5-gd php5-curl curl php5-cli php5-memcached

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Install Drush 7.
RUN composer global require drush/drush:dev-master
RUN composer global update

# Unfortunately, adding the composer vendor dir to the PATH doesn't seem to work. So:
RUN ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush

# Enable apache default server configuration
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf
RUN a2enconf servername

# Enable apache2 modules
RUN a2enmod actions fastcgi rewrite alias

# Add php5-conf file
ADD php5-fpm.conf /etc/apache2/conf-available/php5-fpm.conf

# Enable php5-fpm conf
RUN a2enconf php5-fpm.conf

# Open SSH server configurations
ENV AUTHORIZED_KEYS **None**
ADD ssh/root_pw_set.sh /root_pw_set.sh
ADD ssh/configure.sh /configure.sh
RUN chmod +x /*.sh

# Expose port 80 for apache && 22 for ssh server.
EXPOSE 80 22

# start apache2
CMD ["/configure.sh"]
