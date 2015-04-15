FROM debian:8

RUN apt-get update && \
    apt-get --yes --quiet install \
                          build-essential \
                          curl \
                          git \
                          libffi-dev \
                          libssl-dev \
                          wget \
                          zlib1g-dev \
                          && \
    apt-get clean && \
    cd /usr/local/src && \
    git clone https://github.com/sstephenson/ruby-build.git && \
    cd ruby-build && \
    ./install.sh && \
    ruby-build 2.2.0 /usr/local &&\
    gem update --system && \
    gem install --no-rdoc --no-ri bundler
