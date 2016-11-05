FROM php:apache

RUN apt-get update && apt-get -y install unzip zlib1g-dev git-core supervisor
RUN docker-php-ext-install pdo_mysql zip

RUN chown -R www-data:www-data /var/www/html

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY update_status.sh /usr/local/bin/update_status.sh
COPY start.sh /usr/local/bin/start.sh

WORKDIR /var/www/html
RUN git clone https://github.com/phpservermon/phpservermon.git ./
RUN php composer.phar install
RUN rm -rf Makefile Vagrantfile composer* .git

RUN apt-get remove -y --purge unzip zlib1g-dev git-core

RUN chmod +x /usr/local/bin/update_status.sh
RUN chmod +x /usr/local/bin/start.sh

ENTRYPOINT ["/usr/local/bin/start.sh"]

EXPOSE 80
