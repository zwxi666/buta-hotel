FROM php:8.2-apache

# Установка расширений для работы QloApps
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libicu-dev libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd intl pdo_mysql mysqli

# Включение модуля перезаписи ссылок
RUN a2enmod rewrite

# Копирование файлов сайта
COPY . /var/www/html/

# Настройка прав доступа
RUN chown -R www-data:www-data /var/www/html/
