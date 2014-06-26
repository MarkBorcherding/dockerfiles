FROM fooberry/base

MAINTAINER Mark Borcherding <markborcherding@gmail.com>

# Update apt
RUN apt-get update
RUN apt-get --yes --quiet install build-essential zlib1g-dev

RUN mkdir /src
WORKDIR /src
RUN git clone https://github.com/sstephenson/ruby-build.git
WORKDIR /src/ruby-build
RUN ./install.sh
RUN ruby-build 1.9.3-p547 /usr/local

# Grab Bundler
RUN gem install --no-rdoc --no-ri bundler
