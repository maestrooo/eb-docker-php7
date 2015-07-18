FROM php:7.0-apache

RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev
RUN docker-php-ext-install opcache
RUN docker-php-ext-install intl
RUN docker-php-ext-install pdo_mysql