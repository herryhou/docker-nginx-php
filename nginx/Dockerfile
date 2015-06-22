#https://github.com/nginxinc/docker-nginx
FROM nginx:1.9.2
 RUN ln -sf /usr/share/zoneinfo/Asia/Taipei  /etc/localtime && \
     rm /etc/nginx/nginx.conf && \
     rm /etc/nginx/conf.d/default.conf
 COPY ./default.conf /etc/nginx/conf.d/
 COPY ./nginx.conf /etc/nginx/
 VOLUME /etc/nginx