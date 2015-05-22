
default:
	docker images
	docker ps -a
execphp:
	docker exec -ti phpserver /bin/bash

execnginx:
	docker exec -ti nginx /bin/bash

run:
	docker run --name phpserver -h phpserver -v /var/www/php:/var/www/html:ro -p 9000:9000 -d mwphp:fpm
	docker run --name nginx -h nginx -v /var/www/static:/usr/share/nginx/html:ro --link phpserver:phpserver -p 80:80 -d mwnginx

rm:
	docker stop phpserver
	docker rm phpserver
	docker stop nginx
	docker rm nginx

build:
	docker build -t mwnginx:1.0 .
	docker build -t mwphp:fpm1.1 .