FROM fooberry/base

MAINTAINER Mark Borcherding <markborcherding@gmail.com>

# Update apt
RUN apt-get update

# Install the dependencies
RUN  apt-get install --quiet --yes git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

# Get Ruby source
WORKDIR /tmp
RUN wget http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz

# Expand the tarball
RUN mkdir -p /usr/local/src/ruby
RUN tar -xzf ruby-2.1.2.tar.gz -C /usr/local/src/ruby

# Build it
WORKDIR /usr/local/src/ruby/ruby-2.1.2
RUN ./configure
RUN make
RUN make install

# Grab Bundler
RUN gem install --no-document bundler
