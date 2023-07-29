FROM nginx:stable-alpine

# user variables
ENV NGINXUSER=laravel
ENV NGINXGROUP=laravel

# create folder
RUN mkdir -p /var/www/html/public

# copy default.conf to container
ADD nginx/default.conf /etc/nginx/conf.d/default.conf

# replaces user with our newly created user
RUN sed -i "s/user www-data/user ${NGINXUSER}/g" /etc/nginx/nginx.conf

# creates user and group
RUN adduser -g ${NGINXGROUP} -s /bin/sh -D ${NGINXUSER}