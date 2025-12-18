#!/bin/bash

set -e

#Inicia MariaDB em background
mysqld_safe &

#Espera o banco ficar pronto

until mysqladmin ping --silent; do
    sleep  1
done

mysql -u root << STOP
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
STOP

# Para o processo em background
mysqladmin shutdown

# Inicia Maria DB em primeiro plano (container vivo)

exec mysqld