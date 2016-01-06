FROM php:7.0.1-fpm

RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev libpq-dev
RUN docker-php-ext-install opcache
RUN docker-php-ext-install intl
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pdo_pgsql
RUN pecl install apcu && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini
