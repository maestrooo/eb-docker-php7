FROM php:7.0.3-fpm

COPY config/custom.ini /usr/local/etc/php/conf.d/

RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev libpq-dev libfreetype6 wkhtmltopdf \
    && docker-php-ext-install opcache \
    && docker-php-ext-install intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pdo_pgsql \
    ## APCu
    && pecl install apcu \
    && docker-php-ext-enable apcu

RUN mkdir -p /var/log/php-app
RUN chown www-data:www-data /var/log/php-app

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer