FROM nginx:stable-alpine
COPY mySite.template /etc/nginx/conf.d/
ENV NGINX_PORT 80
ENV NGINX_SERVER_NAME localhost
ENV PHP_TEMPLATE_URI conf.d/php.template
ENV PHP_URI http://localhost:9000
CMD /bin/bash -c "envsubst < /etc/nginx/conf.d/mySite.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
