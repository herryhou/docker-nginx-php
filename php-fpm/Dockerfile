FROM php:5.6-fpm
 # Install modules
 COPY docker-php-ext-* /usr/local/bin/
 RUN ln -sf /usr/share/zoneinfo/Asia/Taipei  /etc/localtime \
     && cp /usr/src/php/php.ini-production /usr/local/etc/php/php.ini \
     && echo 'date.timezone = "Asia/Taipei"' >> /usr/local/etc/php/php.ini \
     && sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /usr/local/etc/php/php.ini

 RUN apt-get update && apt-get install -y \
         freetds-dev \
         libfreetype6-dev \
         libjpeg62-turbo-dev \
         libmcrypt-dev \
         libpng12-dev \
         zlib1g-dev \
         libmemcached-dev \

     && ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so.5 /usr/lib/libsybdb.so \
     && ldconfig -v \
     && docker-php-ext-configure mssql --with-mssql \
     && docker-php-ext-install mssql \
     && docker-php-ext-configure pdo_dblib --with-pdo-dblib \
     && docker-php-ext-install pdo_dblib \
     && docker-php-ext-install iconv mcrypt \
     && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
     && docker-php-ext-install gd \

     && docker-php-ext-download igbinary 1.2.1 \
     && docker-php-ext-install igbinary \

     && docker-php-ext-download memcached 2.2.0 \
     && docker-php-ext-install memcached \

     && docker-php-ext-download memcache 2.2.7 \
     && docker-php-ext-install memcache \

     && docker-php-ext-download redis 2.2.7 \
     && docker-php-ext-configure redis --enable-redis-igbinary \
     && docker-php-ext-install redis \

     && rm -Rf /tmp/pear \
     && apt-get autoclean \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

 COPY ./php-fpm.conf /usr/local/etc/
 COPY www /var/www/html
 CMD ["php-fpm"]