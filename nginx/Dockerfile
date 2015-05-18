FROM nginx:1.9
 RUN ln -sf /usr/share/zoneinfo/Asia/Taipei  /etc/localtime
 RUN rm /etc/nginx/conf.d/default.conf
 COPY ./default.conf /etc/nginx/conf.d/
 COPY ./default.site /etc/nginx/sites-enabled/
 COPY www /usr/share/nginx/html
 VOLUME /usr/share/nginx/html
 VOLUME /etc/nginx
