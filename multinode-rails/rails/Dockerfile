FROM phusion/baseimage:0.9.15

MAINTAINER markborcherding@gmail.com

RUN apt-get update && \
    apt-get install --yes \
            autoconf \
            bison \
            build-essential \
            git \
            libncurses5-dev \
            libreadline6-dev \
            libssl-dev \
            libyaml-dev \
            zlib1g-dev \
            && \
    apt-get clean

RUN mkdir -p /usr/local/src && \
    cd /usr/local/src && \
    git clone https://github.com/sstephenson/ruby-build.git && \
    cd ruby-build && \
    ./install.sh && \
    cd ../ && \
    rm -rf ruby-build

RUN ruby-build 2.1.5 /usr/local

RUN gem update --system
RUN gem install bundler

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7 && \
    apt-get install --yes apt-transport-https ca-certificates && \
    echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" >> /etc/apt/sources.list.d/passenger.list && \
    chown root: /etc/apt/sources.list.d/passenger.list && \
    chmod 600 /etc/apt/sources.list.d/passenger.list && \
    apt-get update && \
    apt-get install --yes \
            nginx-extras \
            passenger \
            && \
    apt-get clean

RUN apt-get install --yes \
            libcurl4-openssl-dev \
            libsqlite3-dev \
            nodejs \
            sqlite3 \
            && \
    apt-get clean

ADD etc/nginx/conf.d/passenger.conf /etc/nginx/conf.d/

RUN passenger-install-nginx-module --auto --languages ruby

RUN mkdir /web_app
ADD example_app/Gemfile /web_app/
ADD example_app/Gemfile.lock /web_app/
RUN cd /web_app && \
    bundle --without development test

RUN rm /etc/nginx/sites-enabled/default
ADD etc/nginx/sites-available/web_app.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/web_app.conf /etc/nginx/sites-enabled/web_app.conf

ADD example_app/ /web_app

