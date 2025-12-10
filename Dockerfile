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

# Para SQLite, também pode ser necessário:
# RUN docker-php-ext-install sqlite3 pdo_sqlite

WORKDIR /var/www/html
