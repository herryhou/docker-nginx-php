FROM php:5.6-fpm
 # Install modules
 RUN ln -sf /usr/share/zoneinfo/Asia/Taipei  /etc/localtime \
     && apt-get update && apt-get install -y \
         unzip \
         freetds-dev \
         libfreetype6-dev \
         libjpeg62-turbo-dev \
         libmcrypt-dev \
         libpng12-dev \
     && ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so.5 /usr/lib/libsybdb.so \
     && ldconfig -v \
     && docker-php-ext-configure mssql --with-mssql \
     && docker-php-ext-install mssql \
     && docker-php-ext-configure pdo_dblib --with-pdo-dblib \
     && docker-php-ext-install pdo_dblib \
     && docker-php-ext-install iconv mcrypt \
     && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
     && docker-php-ext-install gd \

     && pecl install igbinary \
     && docker-php-ext-install igbinary

     && pecl install memcached \
     && docker-php-ext-configure memcached --disable-memcached-session \
     && docker-php-ext-install memcached

     && pecl install memcache \
     && docker-php-ext-configure memcache --enable-memcache --disable-memcache-session \
     && docker-php-ext-install memcache

     && pecl install redis \
     && docker-php-ext-configure redis --enable-redis-igbinary \
     && docker-php-ext-install redis

 COPY ./php-fpm.conf /usr/local/etc/
 RUN cp  /usr/src/php/php.ini-production /usr/local/etc/php/php.ini && \
 	 echo 'date.timezone = "Asia/Taipei"' >> /usr/local/etc/php/php.ini
 COPY www /var/www/html
 CMD ["php-fpm"]