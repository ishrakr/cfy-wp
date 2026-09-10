#!/bin/sh
set -eu

dropin=/var/www/html/wp-content/object-cache.php
disabled_dropin=/var/www/html/wp-content/object-cache.php.redis-disabled
migration_marker=/var/www/html/.cfy-redis-migration-complete

if [ ! -e "$migration_marker" ]; then
    if [ -f "$dropin" ] && grep -q "Redis Object Cache" "$dropin"; then
        if [ -e "$disabled_dropin" ]; then
            rm "$dropin"
        else
            mv "$dropin" "$disabled_dropin"
        fi
    fi

    wp_config=/var/www/html/wp-config.php

    if [ -f "$wp_config" ]; then
        for constant in WP_REDIS_HOST WP_REDIS_PORT WP_REDIS_DATABASE WP_REDIS_TIMEOUT WP_REDIS_READ_TIMEOUT; do
            sed -i "/define([[:space:]]*['\"]$constant['\"]/d" "$wp_config"
        done
    fi

    touch "$migration_marker"
fi

exec /usr/local/bin/docker-entrypoint.sh "$@"
