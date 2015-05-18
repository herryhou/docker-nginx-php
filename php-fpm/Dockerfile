FROM php:5.6-fpm
 # Install modules
 RUN ln -sf /usr/share/zoneinfo/Asia/Taipei  /etc/localtime
 RUN apt-get update && apt-get install -y \
         libfreetype6-dev \
         libjpeg62-turbo-dev \
         libmcrypt-dev \
         libpng12-dev \
     && docker-php-ext-install iconv mcrypt \
     && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
     && docker-php-ext-install gd
 COPY ./php-fpm.conf /usr/local/etc/
 RUN cp  /usr/src/php/php.ini-production /usr/local/etc/php/php.ini && \
 	 echo 'date.timezone = "Asia/Taipei"' >> /usr/local/etc/php/php.ini
 COPY www /var/www/html
 CMD ["php-fpm"]