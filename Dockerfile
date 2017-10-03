FROM php:5.6-fpm-alpine
RUN apk add --no-cache nginx tzdata zlib zlib-dev && \
	echo "fastcgi_param  SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;" >> /etc/nginx/fastcgi_params && \
	echo "fastcgi_split_path_info       ^(.+\.php)(/.+)$;" >> /etc/nginx/fastcgi_params && \
	echo "fastcgi_param PATH_INFO       \$fastcgi_path_info;" >> /etc/nginx/fastcgi_params && \
	echo "fastcgi_param PATH_TRANSLATED \$document_root\$fastcgi_path_info;" >> /etc/nginx/fastcgi_params && \
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	echo "Asia/Shanghai" > /etc/timezone && \
	apk del tzdata && \
	echo "data.timezone = Asia/Shanghai" > /usr/local/etc/php/php.ini && \ 
	docker-php-ext-install pdo_mysql zip
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx -g 'daemon off;' & php-fpm"]


