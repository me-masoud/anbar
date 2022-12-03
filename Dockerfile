FROM php:7.4-apache

COPY ./webserver/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./webserver/box.masoud.me.conf /etc/apache2/sites-available/box.masoud.me.conf
COPY ./webserver/start-apache /usr/local/bin

RUN a2ensite box.masoud.me.conf
RUN a2dissite 000-default.conf

RUN a2enmod rewrite

# Copy application source
COPY ./ /var/www/anbar/
RUN chown -R www-data:www-data /var/www

CMD ["start-apache"]