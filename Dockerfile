FROM php:7.2.2-apache

RUN apt-get update && apt-get install -y \
    git \
    wget \
    zip \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

RUN EXPECTED_SIGNATURE="$(wget -q -O \
        - https://composer.github.io/installer.sig)" && \
    php -r "copy('https://getcomposer.org/installer', \
        'composer-setup.php');" && \
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('SHA384', \
        'composer-setup.php');")" && \
    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; \
        then >&2 echo 'ERROR: Invalid installer signature' ; \
        rm composer-setup.php; exit 1; fi && \
    php composer-setup.php --quiet && \
    rm composer-setup.php && \
    mv composer.phar /usr/local/bin/composer

RUN sed -i 's/DocumentRoot.*$/DocumentRoot \
        \/var\/www\/html\/public/' \
        /etc/apache2/sites-enabled/000-default.conf && \
    sed -i 's/VirtualHost \*:80/VirtualHost \*:8080/' \
        /etc/apache2/sites-enabled/000-default.conf && \
    sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf
 
USER www-data