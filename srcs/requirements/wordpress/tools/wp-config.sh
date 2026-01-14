#!/bin/bash

set -e

env

echo "passou"
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "baixando o wp" 
    wp core download --path=/var/www/html --allow-root

    echo " criando o usuario"
    wp config create --path=/var/www/html \
        --dbname=${DB_NAME} \
        --dbuser=${DB_USER} \
        --dbpass=${DB_PASS} \
        --dbhost="mariadb" \
        --allow-root
    echo " instalando"
    wp core install --path=/var/www/html \
        --url=${DOMAIN} \
        --title="${TITLE}" \
        --admin_user=${WP_ADMIN_NAME} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --skip-email \
        --allow-root

        # wp user create \
        #     "$WP_USER" "$WP_USER_EMAIL" \
        #     --user_pass="$WP_USER_PASS" \
        #     --role=author \
        #     --allow-root
else
    echo " tudo pronot" 
fi
# Iniciar PHP-FPM

echo "Executando o PHP FPM"
exec php-fpm8.2 -F