FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

#Instalar PHP + extensoes necessarias

RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    curl \
    wget \
    mariadb-client \
    && apt-get clean

# Criar directorio do WordPress

RUN mkdir -p /var/www/html

# Baixar WordPress
RUN wget https://wordpress.org/latest.tar.gz -P /tmp \
    && tar -xzf /tmp/latest.tar.gz -C /var/www/html \
    && chown -R www-data:www-data /var/www/html/wordpress

# Copiar script de configuracao
COPY tools/wp-config.sh /wp-config.sh
RUN chmod +x wp-config.sh

WORKDIR /var/www/html/wordpress

EXPOSE 9000

ENTRYPOINT [ "/wp-config.sh" ]