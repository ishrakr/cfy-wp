#!/bin/sh
set -eu

if [ ! -f /var/www/html/wp-load.php ]; then
    cp -a /usr/src/wordpress/. /var/www/html/
fi

if [ ! -f /var/www/html/wp-config.php ] && [ -f /var/www/html/wp-content/object-cache.php ]; then
    mv /var/www/html/wp-content/object-cache.php /var/www/html/wp-content/object-cache.php.disabled
fi

if [ -f /var/www/html/wp-config.php ] && [ -f /var/www/html/wp-content/object-cache.php.disabled ]; then
    mv /var/www/html/wp-content/object-cache.php.disabled /var/www/html/wp-content/object-cache.php
fi

if [ -f /var/www/html/wp-config.php ] && ! grep -q "WP_REDIS_HOST" /var/www/html/wp-config.php; then
    sed -i "/That's all, stop editing/i\\define('WP_REDIS_HOST', 'cache');\ndefine('WP_REDIS_PORT', 6379);\ndefine('WP_REDIS_DATABASE', 0);\ndefine('WP_REDIS_TIMEOUT', 1);\ndefine('WP_REDIS_READ_TIMEOUT', 1);\n" /var/www/html/wp-config.php
fi

chown -R www-data:www-data /var/www/html

exec /usr/local/bin/docker-entrypoint.sh "$@"
