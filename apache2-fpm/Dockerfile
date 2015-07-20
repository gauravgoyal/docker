FROM ubuntu

# Specifying the maintainer for this image.
MAINTAINER Gaurav Goyal "gkg.ras@gmail.com"

# All commands ran in this file must be non interactive.
ENV DEBIAN_FRONTEND noninteractive

# Update the sources.list file to support multiverse packages, used for downlong libapache2-mod-fastcgi

COPY sources.list /etc/apt/sources.list

# Update the system.
RUN apt-get update

# Install Apache mpm worker with php5-fpm

RUN apt-get install -y apache2-mpm-worker libapache2-mod-fastcgi php5-fpm

# Enable apache default server configuration
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf
RUN a2enconf servername

# Enable apache2 modules
RUN a2enmod actions fastcgi rewrite alias

#ENV Vars
ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2

# Add php5-conf file
ADD php5-fpm.conf /etc/apache2/conf-available/php5-fpm.conf

# Enable php5-fpm conf
RUN a2enconf php5-fpm.conf

# Some php5-fpm common changes
RUN sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127\.0\.0\.1\:9000/' /etc/php5/fpm/pool.d/www.conf
RUN sed -i 's/\;listen.mode/listen.mode/' /etc/php5/fpm/pool.d/www.conf

# Expose port 80 for apache inside the container.
EXPOSE 80

ADD src/ /var/www/html/

# start apache2
ADD start.sh /start.sh
RUN chmod 0755 /start.sh
WORKDIR /var/www/html/
CMD ["bash", "start.sh"]
