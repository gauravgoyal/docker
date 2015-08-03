#!/bin/bash

sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php5/fpm/php.ini
sed -i 's/;listen = \/var\/run\/php5-fpm.sock/listen = \/var\/run\/php5-fpm.sock/' /etc/php5/fpm/pool.d/www.conf && sed -i 's/\;listen.mode/listen.mode/' /etc/php5/fpm/pool.d/www.conf && sed -i 's/expose_php.*/expose_php = off/g' /etc/php5/fpm/php.ini && sed -i 's/allow_url_fopen.*/allow_url_fopen = off/g' /etc/php5/fpm/php.ini
sed -i "s/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=staff/" /etc/apache2/envvars
sed -i 's/listen\.group = www-data/listen\.group = staff/' /etc/php5/fpm/pool.d/www.conf

chown -R www-data:staff /var/www
chown -R www-data:staff /var/log/apache2
source /etc/apache2/envvars

if [ "${AUTHORIZED_KEYS}" != "**None**" ]; then
    echo "=> Found authorized keys"
    mkdir -p /root/.ssh
    chmod 700 /root/.ssh
    touch /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    IFS=$'\n'
    arr=$(echo ${AUTHORIZED_KEYS} | tr "," "\n")
    for x in $arr
    do
        x=$(echo $x |sed -e 's/^ *//' -e 's/ *$//')
        cat /root/.ssh/authorized_keys | grep "$x" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "=> Adding public key to /root/.ssh/authorized_keys: $x"
            echo "$x" >> /root/.ssh/authorized_keys
        fi
    done
fi

if [ ! -f /.root_pw_set ]; then
	bin/bash /root_pw_set.sh
fi

service php5-fpm start
service ssh start
/usr/sbin/apache2ctl -D FOREGROUND
