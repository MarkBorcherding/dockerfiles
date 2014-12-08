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

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7 && \
    apt-get install --yes apt-transport-https ca-certificates && \
    echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" >> /etc/apt/sources.list.d/passenger.list && \
    chown root: /etc/apt/sources.list.d/passenger.list && \
    chmod 600 /etc/apt/sources.list.d/passenger.list && \
    apt-get update && \
    apt-get install --yes passenger && \
    apt-get clean

