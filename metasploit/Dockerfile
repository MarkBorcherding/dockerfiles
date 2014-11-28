# Following the instructions at https://github.com/rapid7/metasploit-framework/wiki/Setting-Up-a-Metasploit-Development-Environment
FROM debian:7.7

RUN apt-get update && \
    apt-get --yes install \
                  autoconf \
                  bison \
                  build-essential \
                  curl \
                  git-core \
                  libapr1 \
                  libaprutil1 \
                  libcurl4-openssl-dev \
                  libpcap-dev \
                  libpq-dev \
                  libreadline6-dev \
                  libsqlite3-dev \
                  libssl-dev \
                  libsvn1 \
                  libtool \
                  libxml2 \
                  libxml2-dev \
                  libxslt-dev \
                  libyaml-dev \
                  locate \
                  ncurses-dev \
                  openssl \
                  postgresql \
                  postgresql-contrib \
                  wget \
                  zlib1g \
                  zlib1g-dev && \
    apt-get clean

# Use and blow away ruby-build
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/src/ruby-build && \
    cd /usr/src/ruby-build && \
    ./install.sh && \
    cd && \
    ruby-build 2.1.5 /usr/local && \
    rm -rf /usr/src/ruby-build

# Always forget the ruby docs
RUN echo "gem: --no-rdoc --no-ri " >> /usr/local/etc/gemrc

# Update
RUN gem update --system

# Grab Bundler
RUN gem install bundler

# Clone the framework
RUN git clone https://github.com/rapid7/metasploit-framework.git /usr/local/src/metasploit-framework

RUN cd /usr/local/src/metasploit-framework && \
    bundle install

CMD ['/usr/local/src/metasploit-framework/msfconsole']
