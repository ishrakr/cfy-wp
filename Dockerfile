FROM wordpress:php8.5-apache

# Install the process tools used by the WordPress cron job and Redis extension.
RUN apt-get update && apt-get install -y \
    cron \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install the Redis PHP extension used by WordPress cache integrations.
RUN pecl install redis \
    && docker-php-ext-enable redis

# Enable Apache rewrite support for WordPress permalinks.
RUN a2enmod rewrite

# /etc/cron.d entries require a user field after the schedule.
RUN printf '%s\n' '*/5 * * * * www-data curl -fsS http://localhost/wp-cron.php?doing_wp_cron >/dev/null 2>&1' > /etc/cron.d/wp-cron \
    && chmod 0644 /etc/cron.d/wp-cron

COPY docker-entrypoint-init.sh /usr/local/bin/docker-entrypoint-init.sh
RUN chmod 0755 /usr/local/bin/docker-entrypoint-init.sh

# Run cron alongside the Apache foreground process.
ENTRYPOINT ["docker-entrypoint-init.sh"]
CMD ["sh", "-c", "cron && apache2-foreground"]
