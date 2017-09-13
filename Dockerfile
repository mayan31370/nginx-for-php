FROM php:5.6-fpm-alpine
RUN apk add --no-cache nginx supervisor tzdata zlib zlib-dev && \
	echo "fastcgi_param  SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;" >> /etc/nginx/fastcgi_params && \
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	echo "Asia/Shanghai" > /etc/timezone && \
	apk del tzdata && \
	docker-php-ext-install pdo_mysql zip
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisord.conf
EXPOSE 80
CMD ["/usr/bin/supervisord"]


