# docker

## MYSQL Container Initialize

docker run  -d -e MYSQL_PASS="test" -e MYSQL_USER="admin" -v $(pwd)/mysql-test:/var/lib/mysql --name db tutum/mysql

---------------------------------------------

## Apache2 php container with mysql container connection

docker run -d -p 8080:80 -v $(pwd)/apache2-fpm:/var/www/html/ --name web --link db:db gauravgoyal/apache2-mpm-php5-fpm:drupal

---------------------------------------------

## Run both the containers with use of docker-compse

- Install Docker compose - https://docs.docker.com/compose/
- Create Drupal Code Directory /home/{your-user}/Drupal/code/drupal
- Create Mysql database directory /home/{your-user}/Drupal/mysql
- Update these direcotry in docker-compose.yml file.

---------------------------------------------

- Run docker-compose up -d, and you are all done.

---------------------------------------------

- For creating a databse either use mysql container bash prompt, or create via php.

---------------------------------------------

## SSH Configuration:

- SSH is currently enabled for Apache2 Image only.
- docker logs {container-id} - this will give you the password for root user.

- you can supply your own password using 'ROOT_PASS' variable.
- you can also add your authenticated keys using 'AUTHORIZED_KEYS' variable.
