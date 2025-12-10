FROM php:8.1-apache

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get update --allow-releaseinfo-change && \
    apt-get install -y libicu-dev libonig-dev libzip-dev unzip zlib1g-dev sqlite3 libsqlite3-dev && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install bcmath intl mbstring pdo pdo_mysql mysqli pdo_sqlite

WORKDIR /var/www/html

# Copiar os arquivos do LinkStack
COPY linkstack/ /var/www/html/

# Preparar banco SQLite
RUN mkdir -p /var/www/html/database /data && \
    chown -R www-data:www-data /var/www/html/database /data && \
    chmod -R 755 /var/www/html/database /data

EXPOSE 80
