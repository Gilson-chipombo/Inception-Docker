#!/bin/bash

set -e

env

echo "passou"
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "baixando o wp" 
    wp core download --path=/var/www/html --allow-root

    echo " criando o usuario"
    wp config create --path=/var/www/html \
        --dbname=$(cat /run/secrest/db_name) \
        --dbuser=$(cat /run/secrets/db_user) \
        --dbpass=$(cat /run/secrets/db_pass) \
        --dbhost="mariadb" \
        --allow-root
    echo " instalando"
    wp core install --path=/var/www/html \
        --url=${DOMAIN} \
        --title=${TITLE} \
        --admin_user=$(cat /run/secrets/wp_admin_name) \
        --admin_password=$(cat /run/secrets/wp_admin_pass) \
        --admin_email=$(cat /run/secrets/wp_admin_email) \
        --skip-email \
        --allow-root

         wp user create \
             "$WP_USER" "$WP_USER_EMAIL" \
             --user_pass="$(cat /run/secrets/wp_user_pass)" \
             --role=author \
             --allow-root
else
    echo " tudo pronot" 
fi
# Iniciar PHP-FPM
exec php-fpm8.2 -F