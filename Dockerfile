FROM wordpress:php8.5-apache

EXPOSE 80

# Avoid Apache startup warnings when the container hostname is not resolvable.
RUN printf '%s\n' 'ServerName localhost' > /etc/apache2/conf-available/servername.conf \
    && a2enconf servername

COPY custom.ini /usr/local/etc/php/conf.d/custom.ini
