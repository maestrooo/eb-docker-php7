FROM php:7.0.33-fpm

ENV DEBIAN_FRONTEND noninteractive
COPY config/custom.ini /usr/local/etc/php/conf.d/

RUN apt-get clean && apt-get update && apt-get install -y zlib1g-dev libicu-dev libpq-dev libfreetype6 wget gdebi libmagickwand-dev libmagickcore-dev imagemagick \
    --no-install-recommends \
    && docker-php-ext-install opcache \
    && docker-php-ext-install intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install zip \
    ## APCu
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    # Image Magick
    && pecl install imagick \
    #&& docker-php-ext-enable imagick
    && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini

RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.2.1/wkhtmltox-0.12.2.1_linux-jessie-amd64.deb
# RUN gdebi --n wkhtmltox-0.12.2.1_linux-jessie-amd64.deb

RUN wget https://github.com/DataDog/dd-trace-php/releases/download/0.55.0/datadog-php-tracer_0.55.0_amd64.deb \
    && mv datadog-php-tracer_0.55.0_amd64.deb datadog-php-tracer.deb \
    && dpkg -i datadog-php-tracer.deb

RUN mkdir -p /var/log/php-app
RUN chown www-data:www-data /var/log/php-app

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
