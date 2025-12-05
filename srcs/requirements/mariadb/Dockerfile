FROM ubuntu

RUN apt-get update && apt-get install -y mariadb-server

# Criar o diretório de runtime do MariaDB
RUN mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld

# Criar pasta de inicialização
RUN mkdir -p /docker-entrypoint-initdb.d \
    && chown -R mysql:mysql /docker-entrypoint-initdb.d

#COPY my.cnf /etc/mysql/my.cnf

COPY tools/init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

CMD ["mysqld"]
