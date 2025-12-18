FROM debian:bullseye

ENV DEBIAN_FRONTEND=moninteractive

RUN apt-get update -y && \
    apt-get install -y mariadb-server && \
    apt-get clean

# Cria directorios que o MariaDB precisa

RUN mkdir -p /run/mysqld && \
        chown -R mysql:mysql /run/mysqld

#Copia script de inicializacao
COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 3306

#Inicia o script (nao o mysqld direto!)

ENTRYPOINT [ "/init.sh"]
