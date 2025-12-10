FROM php:8.2-apache

# Instala dependências do sistema e extensões PHP necessárias
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libonig-dev \
    libzip-dev \
    unzip \
    zlib1g-dev \
    sqlite3 \
    && docker-php-ext-install bcmath intl mbstring pdo pdo_sqlite pdo_mysql mysqli

# Copia o projeto para o Apache
COPY . /var/www/html/

# Dá permissão para que SQLite consiga escrever
RUN chown -R www-data:www-data /var/www/html/database \
    && chmod -R 755 /var/www/html/database

# Expõe porta do Apache
EXPOSE 80

# Start command (o Apache já inicia por padrão)
