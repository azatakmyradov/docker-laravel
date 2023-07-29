FROM node:current-alpine

ENV NODEUSER=laravel
ENV NODEGROUP=laravel

RUN adduser -g ${NODEGROUP} -s /bin/sh -D ${NODEUSER}