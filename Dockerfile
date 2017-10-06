FROM php:5.6-fpm-alpine
RUN apk add --no-cache nginx supervisor py-pip tzdata zlib zlib-dev g++ make autoconf curl curl-dev libcurl php5-curl && \
	pecl install xdebug && \
	pip install supervisor-stdout && \
	echo "fastcgi_param  SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;" >> /etc/nginx/fastcgi_params && \
	echo "fastcgi_split_path_info       ^(.+\.php)(/.+)$;" >> /etc/nginx/fastcgi_params && \
	echo "fastcgi_param PATH_INFO       \$fastcgi_path_info;" >> /etc/nginx/fastcgi_params && \
	echo "fastcgi_param PATH_TRANSLATED \$document_root\$fastcgi_path_info;" >> /etc/nginx/fastcgi_params && \
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	echo "Asia/Shanghai" > /etc/timezone && \
	apk del tzdata && \
	echo "data.timezone = Asia/Shanghai" > /usr/local/etc/php/php.ini && \ 
	docker-php-ext-install pdo_mysql zip curl iconv mbstring posix && \
	mkdir /usr/local/php/modules && cp /usr/local/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so /usr/local/php/modules/ && \
	docker-php-ext-enable xdebug && \
	echo "zend_extension=\"/usr/local/php/modules/xdebug.so\"" > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisord.conf
EXPOSE 80
CMD ["/usr/bin/supervisord"]
