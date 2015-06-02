
default:
	docker images
	docker ps -a
execphp:
	docker exec -ti phpserver /bin/bash

execnginx:
	docker exec -ti vagrant_nginx_1 /bin/bash

run:
	docker run --name vagrant_phpserver_1 -h phpserver -v /vagrant/php-fpm/www:/var/www/html:ro -p 9000:9000 -d vagrant_phpserver:latest
	docker run --name vagrant_nginx_1 --log-driver="syslog" -h nginx -v /vagrant/nginx/www:/usr/share/nginx/html:ro --link phpserver:phpserver -p 80:80 -d vagrant_nginx:latest

rm:
	docker stop vagrant_phpserver_1
	docker rm vagrant_phpserver_1
	docker stop vagrant_nginx
	docker rm vagrant_nginx

build:
	docker build -t vagrant_phpserver_1:latest .
	docker build -t vagrant_nginx_1:latest .