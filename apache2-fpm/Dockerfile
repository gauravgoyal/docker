FROM ubuntu

# Specifying the maintainer for this image.
MAINTAINER Gaurav Goyal "gkg.ras@gmail.com"

# All commands ran in this file must be non interactive.
ENV DEBIAN_FRONTEND noninteractive

# Update the sources.list file to support multiverse packages, used for downlong libapache2-mod-fastcgi

COPY sources.list /etc/apt/sources.list

# Update the system.
RUN apt-get update --fix-missing

# Install Apache mpm worker with php5-fpm

RUN apt-get install -y apache2-mpm-worker libapache2-mod-fastcgi php5-fpm php5-mysql mysql-client php5-gd openssh-server

# Enable apache default server configuration
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf
RUN a2enconf servername

# Enable apache2 modules
RUN a2enmod actions fastcgi rewrite alias

#ENV Vars
ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_PID_FILE    /var/run/apache2.pid
ENV APACHE_RUN_DIR     /var/run/apache2
ENV APACHE_LOCK_DIR    /var/lock/apache2

# Add php5-conf file
ADD php5-fpm.conf /etc/apache2/conf-available/php5-fpm.conf

# Enable php5-fpm conf
RUN a2enconf php5-fpm.conf

# Some php5-fpm common changes
RUN sed -i 's/;listen = \/var\/run\/php5-fpm.sock/listen = \/var\/run\/php5-fpm.sock/' /etc/php5/fpm/pool.d/www.conf
RUN sed -i 's/\;listen.mode/listen.mode/' /etc/php5/fpm/pool.d/www.conf

# Open SSH server configurations
ENV AUTHORIZED_KEYS **None**
ADD ssh/root_pw_set.sh /root_pw_set.sh
ADD ssh/configure.sh /configure.sh
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN chmod +x /*.sh

# Expose port 80 for apache inside the container.
EXPOSE 80

# EXPOSE port 22 for SSH server
EXPOSE 22

# start apache2
CMD ["/configure.sh"]
