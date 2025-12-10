FROM php:8.1-apache

ENV DEBIAN_FRONTEND=noninteractive

# Limpar cache e atualizar
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get update --allow-releaseinfo-change

# Instalar pacotes necessários
RUN apt-get install -y \
    libicu-dev \
    libonig-dev \
    libzip-dev \
    unzip \
    zlib1g-dev \
    sqlite3 \
    libsqlite3-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Instalar extensões PHP
RUN docker-php-ext-install \
    bcmath \
    intl \
    mbstring \
    pdo \
    pdo_mysql \
    mysqli \
    pdo_sqlite

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Definir diretório de trabalho
WORKDIR /var/www/html

# Copiar os arquivos do LinkStack
COPY . /var/www/html/

# Instalar dependências do PHP via Composer
RUN composer install --no-dev --optimize-autoloader

# Preparar pastas do banco SQLite
RUN mkdir -p /var/www/html/database /data && \
    chown -R www-data:www-data /var/www/html/database /data && \
    chmod -R 755 /var/www/html/database /data

EXPOSE 80
