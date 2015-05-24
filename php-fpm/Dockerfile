FROM php:5.6-fpm
 # Install modules
 RUN ln -sf /usr/share/zoneinfo/Asia/Taipei  /etc/localtime \
     && apt-get update && apt-get install -y \
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

     && pecl install igbinary-1.2.1 \
     && echo "extension=igbinary.so" > /usr/local/etc/php/conf.d/ext-igbinary.ini \

     && mkdir -p /tmp/pear/download \

     && cd /tmp/pear/download \
     && pecl download memcached-2.2.0 \
     && mkdir -p /usr/src/php/ext/memcached \
     && tar -xvzf memcached-* -C /usr/src/php/ext/memcached --strip-components 1 \
     && cd /usr/src/php/ext/memcached \
     && docker-php-ext-install memcached \

     && cd /tmp/pear/download \
     && pecl download memcache-2.2.7 \
     && mkdir -p /usr/src/php/ext/memcache \
     && tar -xvzf memcache-* -C /usr/src/php/ext/memcache --strip-components 1 \
     && cd /usr/src/php/ext/memcache \
     && docker-php-ext-install memcache \

     && cd /tmp/pear/download \
     && pecl download redis-2.2.7 \
     && mkdir -p /usr/src/php/ext/redis \
     && tar -xvzf redis-* -C /usr/src/php/ext/redis --strip-components 1 \
     && cd /usr/src/php/ext/redis \
     && docker-php-ext-configure redis --enable-redis-igbinary \
     && docker-php-ext-install redis \

     && cp /usr/src/php/php.ini-production /usr/local/etc/php/php.ini \
     && echo 'date.timezone = "Asia/Taipei"' >> /usr/local/etc/php/php.ini

 COPY ./php-fpm.conf /usr/local/etc/
 COPY www /var/www/html
 CMD ["php-fpm"]