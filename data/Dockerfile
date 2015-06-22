FROM debian:jessie

RUN mkdir -p /var/www/html
VOLUME ["/var/www"]
COPY www /var/www/html

ENTRYPOINT /usr/bin/tail -f /dev/null