#!/bin/bash

set -e

# Espera o MariaDB ficar disponivel
until mysqladmin ping -h mariadb -u $DB_USER -p  $DB_PASS --silent; do
    sleep 1
done

# Criar wp-config.php se nao existir

if [! -f wp-config.php ]; then
    cp wp-config-simple.php wp-config.php

    sed -i "s/database_name_here/${DB_NAME}/" wp-config.php
    sed -i "s/username_here/${DB_USER}/" wp-config.php
    sed -i "s/password_here/${DB_PASS}/" wp-config.php
    sed -i "s/localhost/mariadb/"wp-config.php
fi

# Iniciar PHP-FPM
exec php-fpm7.4 -F