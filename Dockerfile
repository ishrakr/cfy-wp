FROM wordpress:php8.5-apache

RUN pecl install redis-6.3.0 \
    && docker-php-ext-enable redis

COPY custom.ini /usr/local/etc/php/conf.d/custom.ini
