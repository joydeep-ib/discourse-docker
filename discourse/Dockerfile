FROM debian:buster

LABEL maintainer="joydeep@scaler.com"

ENV PG_MAJOR=13 \
    NODE_VERSION="14.17.6" \
    RUBY_ALLOCATOR="/usr/lib/libjemalloc.so.1" \
    RAILS_ENV="production" \
    OS_ARCH="amd64" \
    OS_FLAVOUR="debian-10" \
    OS_NAME="linux" \
    LC_ALL="en_US.UTF-8" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8"

COPY base.sh /build_scripts/base.sh 
RUN . /build_scripts/base.sh

RUN useradd discourse -s /bin/bash -m -U &&\
    mkdir -p /var/www/discourse/public &&\
    ln -s /var/www/discourse /home/discourse/

VOLUME ["/var/www/discourse/public-nginx"]


RUN cd /var/www/discourse &&\
    git init &&\
    git remote add origin https://github.com/joydeep-ib/discourse.git &&\
    git fetch origin tests-passed --depth 1 &&\
    git checkout tests-passed &&\
    su discourse && \
    bundle install --deployment --jobs 4 --without test development &&\
    yarn install --production &&\
    yarn cache clean &&\
    bundle exec rake maxminddb:get &&\
    chown -R discourse:discourse /var/www/discourse &&\
    find /var/www/discourse/vendor/bundle -name tmp -type d -exec rm -rf {} +;

ARG database_host=127.0.0.1
ARG database_port=5439
ARG database_password
ARG database_user
ARG database_name
ARG redis_host=127.0.0.1
ARG redis_port=6379

ENV DISCOURSE_HOST=www.interviewbit.com \
    DISCOURSE_HOSTNAME=www.interviewbit.com \
    DISCOURSE_RELATIVE_URL_ROOT=/community \
    DISCOURSE_DB_HOST=$database_host \
    DISCOURSE_DB_NAME=$database_name \
    DISCOURSE_DB_PASSWORD=$database_password \
    DISCOURSE_DB_PORT=$database_port \
    DISCOURSE_DB_USERNAME=$database_user \
    DISCOURSE_DATABASE_USER=$database_user \
    DISCOURSE_REDIS_HOST=$redis_host\
    DISCOURSE_REDIS_PORT_NUMBER=$redis_port

RUN chown -R discourse:discourse /var/www/discourse/tmp && \
    chown -R discourse:discourse /var/www/discourse/log && \
    cd /var/www/discourse && \
    bin/bundle exec rake db:migrate && \
    bin/bundle exec rake assets:precompile;
