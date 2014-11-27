FROM fooberry/base

MAINTAINER Mark Borcherding <markborcherding@gmail.com>

# Update apt
RUN apt-get update &&\
    apt-get --yes --quiet install build-essential zlib1g-dev libssl-dev

# Install ruby-build
RUN cd /usr/local/src &&\
    git clone https://github.com/sstephenson/ruby-build.git &&\
    cd ruby-build &&\
    ./install.sh

# Install Ruby
RUN ruby-build 2.1.5 /usr/local

# Update
RUN gem update --system

# Grab Bundler
RUN gem install --no-rdoc --no-ri bundler
