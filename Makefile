
default:
	docker images
	docker ps -a
execphp:
	docker exec -ti phpserver /bin/bash

execnginx:
	docker exec -ti vagrant_nginx_1 /bin/bash

run:
	docker run --name vagrant_phpserver_1 -h phpserver -v /vagrant/php-fpm/www:/var/www/html:ro -p 9000:9000 -d vagrant_phpserver:latest
	docker run --name vagrant_nginx_1 --log-driver="syslog" -h nginx -v /vagrant/nginx/www:/usr/share/nginx/html:ro --link vagrant_phpserver_1:phpserver -p 80:80 -d vagrant_nginx:latest

rm:
	docker ps -aq | xargs docker stop && docker ps -aq | xargs docker rm

build:
	docker build -t vagrant_phpserver:latest /vagrant/php-fpm/.
	docker build -t vagrant_nginx:latest /vagrant/nginx/.



buildAll:
	docker ps -aq | xargs docker stop && docker ps -aq | xargs docker rm
	docker rmi vagrant_nginx:latest
	docker build -t vagrant_nginx:latest /vagrant/nginx/.
	docker run --name vagrant_phpserver_1 -h phpserver -v /vagrant/php-fpm/www:/var/www/html:ro -p 9000:9000 -d vagrant_phpserver:latest
	docker run --name vagrant_nginx_1 --log-driver="syslog" -h nginx -v /vagrant/nginx/www:/usr/share/nginx/html:ro --link vagrant_phpserver_1:phpserver -p 80:80 -d vagrant_nginx:latest

	sudo cp /vagrant/10-docker.conf   /etc/rsyslog.d/
	sudo cp /vagrant/11-elasticsearch.conf   /etc/rsyslog.d/
	sudo service rsyslog restart

	curl localhost/
	curl localhost/iii.php
	curl localhost/iii.php?l=1
	curl localhost/test/iii.php?l=1
	curl localhost/iii.php/
	curl localhost/test/iii.php/
	curl localhost/iii.php?l=2
	curl localhost/test/iii.php?l=2
	curl localhost/test/iii.php?l=2&b=3

	cd /vagrant
	docker-compose logs

