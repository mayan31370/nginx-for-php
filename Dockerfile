FROM nginx:stable-alpine
COPY mySite.template /etc/nginx/conf.d/
COPY fastcgi_params /etc/nginx/
ENV NGINX_PORT 80
ENV PHP_URI http://localhost:9000
CMD /bin/sh -c "envsubst < /etc/nginx/conf.d/mySite.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
