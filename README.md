#安裝 nginx 以及 php-fpm docker

##最簡單的使用方式 － 使用 vagrant

1. git clone https://github.com/herryhou/docker-nginx-php
2. cd docker-nginx-php && vagrant up
3. 打開 browser, [http://localhost:8000/iii.php](http://localhost:8000/iii.php)

## docker container 說明
1. data container 網頁資料(*.php, *.html, *.js , *.css, *.png...), container 裡面的資料目錄在 /var/www/html
2. nginx
3. varnish (版本 4.0 作為 nginx 的 cache 用的）
4. php-fpm
5. cAdvisor (docker 的 monitor)
5. nessus (弱點掃描工具, compose 不會自動 up)

## log 的處理
1. container nginx 的 log 送到 host 上 (由檔案 ```docker-composer.yml``` 裡面的設定 ```log_driver: syslog``` 指定的）
2. nginx 的 log format 設定為 json （nginx.cong 裡面的 ```log_format```, 注意 json 格式前加上了 @cee:)
3. 在 host 由 rsyslog 處理，轉送給 elasticsearch. 

##vagrant 成功啟動後，就可以

在瀏覽器裡

1. Web  - [http://localhost:8000/iii.php](http://localhost:8000/iii.php)
2. cAdvisor - [http://localhost:8090/](http://localhost:8090/)

![k3](https://cloud.githubusercontent.com/assets/8790813/8267256/75b7551c-178b-11e5-93cd-bed707190b3e.png)


##調整虛擬機數量, vagrant 預設為啟動1個 VMs
1. 設定環境變數 `NODES_NO＝1`， 或者
2. 修改檔案 `Vagrantfile` 裡面的  `num_nodes = (ENV['NODES_NO'] || 2).to_i` 的數字2

##預設安裝的 php extension 有下列幾個
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

修改 `/php-fpm/Dockerfile`, 加入以下3 行 (以 redis 為例子）
```
     && docker-php-ext-download redis 2.2.7 \
     && docker-php-ext-configure redis --enable-redis-igbinary \
     && docker-php-ext-install redis \
```
其中
  * redis 部分為 extension name, 2.2.7 為版本(可省略)
  * 第二行的 `configure` 是設定參數,可省略
  * 下載 extension 是呼叫`pecl download`
  * 要查詢 package 的版本等資料，請到[https://pecl.php.net](https://pecl.php.net)查詢

參考來源:[https://github.com/William-Yeh/docker-enabled-vagrant/tree/master/debian-jessie](https://github.com/William-Yeh/docker-enabled-vagrant/tree/master/debian-jessie)

