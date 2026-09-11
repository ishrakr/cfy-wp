FROM php:8.2-apache

# 1. Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libxml2-dev \
    zip \
    unzip \
    cron \
    && rm -rf /var/lib/apt/lists/*

# 2. Install extensions AND the Redis driver
# We use pecl for redis because it isn't bundled in the core php-ext-install list
RUN docker-php-ext-install mysqli soap gd exif opcache \
    && pecl install redis \
    && docker-php-ext-enable redis

# 3. Enable Apache rewrite module for .htaccess
RUN a2enmod rewrite

# 4. Include custom PHP settings
COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

# 5. Setup Cron
RUN echo "*/5 * * * * curl -s http://localhost/wp-cron.php?doing_wp_cron > /dev/null 2>&1" > /etc/cron.d/wp-cron \
    && chmod 0644 /etc/cron.d/wp-cron

# 6. Start Cron and Apache
CMD ["sh", "-c", "cron && apache2-foreground"]
