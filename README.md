#安裝 nginx 以及 php-fpm docker

##最簡單的使用方式 － 使用 vagrant

1. git clone https://github.com/herryhou/docker-nginx-php
2. cd docker-nginx-php && vagrant up
3. 打開 browser, http://localhost:8000/iii.php

##調整虛擬機數量, vagrant 預設為啟動兩個 VMs

1. 設定環境變數 `NODES_NO＝1`， 或者
2. 修改檔案 `Vagrantfile` 裡面的  `num_nodes = (ENV['NODES_NO'] || 2).to_i` 的數字2

##預設安裝的 php extension
1. mssql (freetds)
2. pdo_dblib
3. iconv
4. mcrypt
5. gd
6. igbinary v1.2.1
7. memcached v2.2.0
8. memcache v2.2.7
9. redis v2.2.7

##如果要另外安裝 php extension

修改 `/php-fpm/Dockerfile`, 加入以下3 行
```
     && docker-php-ext-download redis 2.2.7 \
     && docker-php-ext-configure redis --enable-redis-igbinary \
     && docker-php-ext-install redis \
```
其中
  * redis 部分為 extension name, 2.2.7 為版本(可省略)
  * 第二行的 `configure` 是設定參數,可省略
  * 下載 extension 是呼叫`pecl download`

參考來源:https://github.com/William-Yeh/docker-enabled-vagrant/tree/master/debian-jessie

