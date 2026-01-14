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
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Para servidor temporário
mysqladmin --socket=/run/mysqld/mysqld.sock shutdown

# Inicia MariaDB DEFINITIVO (foreground)
exec mysqld --user=mysql --bind-address=0.0.0.0
