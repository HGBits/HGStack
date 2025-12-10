FROM php:8.2-apache

# Ativa módulos necessários
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copia tudo para o Apache
COPY . /var/www/html/

EXPOSE 80
