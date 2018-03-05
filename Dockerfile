FROM php:7.2.2-apache

RUN apt-get update && apt-get install -y \ 
  git \
  wget \
  zip \
  && rm -rf /var/lib/apt/lists/*

COPY composer-install.sh ./ 
RUN chmod 744 composer-install.sh; sync && \
  ./composer-install.sh && \
  mv composer.phar /usr/local/bin/composer && \
  rm -f composer-install.sh

RUN a2enmod rewrite && \
  sed -i 's/DocumentRoot.*$/DocumentRoot \/var\/www\/html\/public/' /etc/apache2/sites-enabled/000-default.conf
