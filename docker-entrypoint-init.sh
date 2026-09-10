#!/bin/sh
set -eu

if [ ! -f /var/www/html/wp-load.php ]; then
    cp -a /usr/src/wordpress/. /var/www/html/
fi

if [ -f /var/www/html/wp-content/object-cache.php ]; then
    mv /var/www/html/wp-content/object-cache.php /var/www/html/wp-content/object-cache.php.disabled
fi

chown -R www-data:www-data /var/www/html

exec /usr/local/bin/docker-entrypoint.sh "$@"
