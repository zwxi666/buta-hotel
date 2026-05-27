FROM php:8.2-apache

# Установка всех необходимых расширений
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libicu-dev libxml2-dev libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd intl pdo_mysql mysqli soap zip

# Включение модуля перезаписи ссылок
RUN a2enmod rewrite

# Создание конфигурационного файла PHP для исправления upload_max_filesize
RUN echo "upload_max_filesize = 16M" > /usr/local/etc/php/conf.d/uploads.ini \
    && echo "post_max_size = 20M" >> /usr/local/etc/php/conf.d/uploads.ini

# Копирование файлов и права
COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html/
