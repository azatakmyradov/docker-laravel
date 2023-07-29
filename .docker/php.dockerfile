FROM php:8-fpm-alpine

# user variables
ENV PHPGROUP=laravel
ENV PHPUSER=laravel

# create user
RUN adduser -g ${PHPGROUP} -s /bin/sh -D ${PHPUSER}

# replace user in php configuration
RUN sed -i "s/user = www-data/user = ${PHPUSER}/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = ${PHPGROUP}/g" /usr/local/etc/php-fpm.d/www.conf

# create folder
RUN mkdir -p /var/www/html/public

# required for php-simplexml
RUN apk add libxml2-dev
# required for php-intl
RUN apk add oniguruma
RUN apk add icu-dev
# required for php-zip
RUN apk add libzip-dev

RUN docker-php-ext-install pdo_mysql pdo simplexml intl soap zip \
	&& docker-php-ext-enable pdo_mysql pdo simplexml intl soap zip

CMD [ "php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R" ]