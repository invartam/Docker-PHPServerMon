FROM invartam/docker-alpine-php-fpm-advanced

WORKDIR /app
RUN apk add git \
    && git clone https://github.com/phpservermon/phpservermon.git ./ \
    && git checkout eadc9b145e574a43d4daad132d7de9157d9e2fe6 \
    && php composer.phar install \
    && rm -rf Makefile Vagrantfile composer* .git \
    && apk del git

COPY supervisord.conf /etc/supervisord.conf
COPY update_status.sh /usr/local/bin/update_status.sh
COPY start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/update_status.sh
RUN chmod +x /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]

EXPOSE 80
