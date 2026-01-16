#!/bin/bash
set -e

# Inicia MariaDB TEMPORARIAMENTE como mysql (sem rede)
mysqld --user=mysql --skip-networking --socket=/run/mysqld/mysqld.sock &

# Espera o socket existir
until mysqladmin ping --socket=/run/mysqld/mysqld.sock --silent; do
    sleep 1
done

# Inicialização
mysql --socket=/run/mysqld/mysqld.sock -u root <<EOF
CREATE DATABASE IF NOT EXISTS $(cat /run/secrets/db_name);
CREATE USER IF NOT EXISTS '$(cat /run/secrets/db_user)'@'%' IDENTIFIED BY '$(cat /run/secrets/db_pass)';
GRANT ALL PRIVILEGES ON $(cat /run/secrets/db_name).* TO '$(cat /run/secrets/db_user)'@'%';
FLUSH PRIVILEGES;
EOF

# Para servidor temporário
mysqladmin --socket=/run/mysqld/mysqld.sock shutdown

# Inicia MariaDB DEFINITIVO (foreground)
exec mysqld --user=mysql --bind-address=0.0.0.0
