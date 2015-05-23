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

     && cd /tmp \
     && pecl download memcached-2.2.0.tgz \
     && tar -xvzf memcached-2.2.0.tgz \
     && cd memcached-2.2.0 \
     && phpize \
     && ./configure && make && make install \
     && echo "extension=memcached.so" > /usr/local/etc/php/conf.d/ext-memcached.ini \
     && rm /tmp/memcached-2.2.0.tgz \
     && rm -Rf /tmp/memcached-2.2.0 \

     && cd /tmp \
     && pecl download memcache-2.2.7.tgz \
     && tar -xvzf memcache-2.2.7.tgz \
     && cd memcache-2.2.7 \
     && phpize \
     && ./configure && make && make install \
     && echo "extension=memcache.so" > /usr/local/etc/php/conf.d/ext-memcache.ini \
     && rm /tmp/memcache-2.2.7.tgz \
     && rm -Rf /tmp/memcache-2.2.7 \

     && cd /usr/src/php/ext/ \
     && pecl download redis-2.2.7.tgz \
     && tar -xvzf redis-2.2.7.tgz \
     && rm redis-2.2.7.tgz \
     && mv redis-2.2.7 redis \
     && cd redis \
     && docker-php-ext-configure redis --enable-redis-igbinary \
     && docker-php-ext-install redis \

     && cp /usr/src/php/php.ini-production /usr/local/etc/php/php.ini \
     && echo 'date.timezone = "Asia/Taipei"' >> /usr/local/etc/php/php.ini

 COPY ./php-fpm.conf /usr/local/etc/
 COPY www /var/www/html
 CMD ["php-fpm"]