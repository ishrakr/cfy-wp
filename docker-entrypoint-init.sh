#!/bin/sh
set -eu

if [ ! -f /var/www/html/wp-load.php ]; then
    cp -a /usr/src/wordpress/. /var/www/html/
fi

chown -R www-data:www-data /var/www/html

exec /usr/local/bin/docker-entrypoint.sh "$@"
