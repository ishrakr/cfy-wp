FROM wordpress:php8.5-apache

RUN pecl install redis-6.3.0 \
    && docker-php-ext-enable redis

COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
    CMD curl -f http://localhost/wp-login.php || exit 1
