FROM php:7.1-fpm

COPY config/custom.ini /usr/local/etc/php/conf.d/

RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev libpq-dev \
    && docker-php-ext-install opcache \
    && docker-php-ext-install intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pdo_pgsql \
    ## APCu
    && pecl install apcu-5.1.5 \
    && docker-php-ext-enable apcu

# New curl version
RUN apt-get update \
    && apt-get install -y libssl-dev wget ca-certificates \
    && apt-get purge --auto-remove -y curl libcurl3 \
    && wget --no-check-certificate https://curl.se/download/curl-7.79.1.tar.gz \
    && tar -xzf curl-7.79.1.tar.gz \
    && cd curl-7.79.1 \
    && ./configure --with-ssl --prefix=/usr \
    && make && make install \
    && ldconfig \
    && cd .. && rm -rf curl-7.79.1 \
    && rm -rf /var/lib/apt/lists/*
