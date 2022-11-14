FROM php:7.4-apache

RUN apt-get update && apt-get -y install libjpeg-dev libpng-dev zlib1g-dev git zip
RUN docker-php-ext-configure gd \
        --with-png-dir=/usr/include \
        --with-jpeg-dir=/usr/include \
    && docker-php-ext-install gd \
    && docker-php-ext-enable gd


COPY ./webserver/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./webserver/start-apache /usr/local/bin
RUN a2enmod rewrite

# Copy application source
COPY ./ /var/www/anbar/
RUN chown -R www-data:www-data /var/www

CMD ["start-apache"]