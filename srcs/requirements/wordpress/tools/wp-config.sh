#!/bin/bash

set -e

# Espera o MariaDB ficar disponivel
#until mysqladmin ping -h mariadb -u $DB_USER -p  $DB_PASS --silent; do
#    sleep 1
# #done
mv /var/www/html/wordpress/* /var/www/html/
#rm -rf /var/www/html/wordpress
# Criar wp-config.php se nao existir

#if [! -f wp-config.php ]; then
    cp wp-config-simple.php wp-config.php

    sed -i "s/database_name_here/${DB_NAME}/" wp-config.php
    sed -i "s/username_here/${DB_USER}/" wp-config.php
    sed -i "s/password_here/${DB_PASS}/" wp-config.php
    sed -i "s/localhost/mysql/"wp-config.php
#fi

# Iniciar PHP-FPM

php-fpm8.2 -F