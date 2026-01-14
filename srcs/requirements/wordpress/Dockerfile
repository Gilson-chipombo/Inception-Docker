FROM debian:12

#Instalar PHP + extensoes necessarias

RUN apt update && apt install -y php php-fpm php-curl php-gd php-xml php-mbstring php-zip php-intl php-mysql wget curl tini

# Criar directorio do WordPress

RUN mkdir -p /var/www/html

# Baixar WordPress
RUN wget https://wordpress.org/latest.tar.gz -P /tmp \
    && tar -xzf /tmp/latest.tar.gz -C /var/www/html \
    && chown -R www-data:www-data /var/www/html/


RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
chmod +x wp-cli.phar && \
mv wp-cli.phar /usr/local/bin/wp
# Copiar script de configuracao
COPY ./tools/wp-config.sh wp-config.sh
COPY conf/conf.conf /etc/php/8.2/fpm/pool.d/www.conf
RUN chmod +x wp-config.sh

EXPOSE 9000

ENTRYPOINT ["./wp-config.sh"]