FROM php:7.0.2-fpm

COPY config/custom.ini /usr/local/etc/php/conf.d/

RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev libpq-dev \
    && docker-php-ext-install opcache \
    && docker-php-ext-install intl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pdo_pgsql \
    && pecl install apcu \
    && docker-php-ext-enable apcu
