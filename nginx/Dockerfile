FROM nginx:1.9
 RUN rm /etc/nginx/conf.d/default.conf
 COPY ./default.conf /etc/nginx/conf.d/
 COPY ./default.site /etc/nginx/sites-enabled/
 COPY www /usr/share/nginx/html
 VOLUME /usr/share/nginx/html
 VOLUME /etc/nginx
