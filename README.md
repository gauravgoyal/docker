# docker

## MYSQL Container Initialize

docker run  -d -e MYSQL_PASS="test" -e MYSQL_USER="admin" -v $(pwd)/mysql-test:/var/lib/mysql --name db tutum/mysql

## Apache2 php container with mysql container connection

docker run -d -p 8080:80 -v $(pwd)/apache2-fpm:/var/www/html/ --name web --link db:db gauravgoyal/apache2-mpm-php5-fpm:mysql-client
