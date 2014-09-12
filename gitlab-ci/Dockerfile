FROM phusion/baseimage:0.9.13
MAINTAINER Mark Borcherding <MarkBorcherding@gmail.com>

RUN apt-get --quiet update && \
    apt-get --quiet --yes  upgrade

RUN apt-get -qy install \
      build-essential \
      checkinstall \
      curl \
      gcc \
      git \
      git-core \
      libc6-dev \
      libcurl4-openssl-dev \
      libicu-dev \
      libmysql++-dev \
      libpq-dev \
      libreadline6-dev \
      libssl-dev \
      libxml2-dev \
      libxslt-dev \
      libyaml-dev \
      make \
      openssh-server \
      postfix \
      redis-server \
      vim \
      wget \
      zlib1g-dev

RUN update-alternatives --set editor /usr/bin/vim.basic

# Install ruby-build
RUN cd /usr/local/src &&\
    git clone https://github.com/sstephenson/ruby-build.git &&\
    cd ruby-build &&\
    ./install.sh

# Install Ruby
RUN ruby-build 2.1.2 /usr/local

RUN gem install bundler --no-ri --no-rdoc

RUN adduser --disabled-login --gecos 'GitLab CI' gitlab_ci

# Install the database packages
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get install --yes mysql-server mysql-client libmysqlclient-dev

# Add the setup scripts
ADD etc/my_init.d/99_mysql_setup.sh /etc/my_init.d/99_mysql_setup.sh
RUN chmod +x /etc/my_init.d/99_mysql_setup.sh
ADD var/lib/mysql/setup/01_gitlab.sql /var/lib/mysql/setup/01_gitlab.sql

# Add runit start up
RUN mkdir -p /service/mysql
ADD service/mysql/run /service/mysql/run
RUN chmod +x /service/mysql/run


# Get Gitlab-ci
WORKDIR /home/gitlab_ci/
RUN sudo -u gitlab_ci -H git clone https://gitlab.com/gitlab-org/gitlab-ci.git

# Drop in config files for gitlab
WORKDIR /home/gitlab_ci/gitlab-ci
RUN sudo -u gitlab_ci -H git checkout 5-0-stable
ADD home/gitlab_ci/gitlab-ci/config/application.yml /home/gitlab_ci/gitlab-ci/config/application.yml
ADD home/gitlab_ci/gitlab-ci/config/unicorn.rb /home/gitlab_ci/gitlab-ci/config/unicorn.rb

# Make sockets
RUN sudo -u gitlab_ci -H mkdir -p tmp/sockets/
RUN sudo chmod -R u+rwX  tmp/sockets/
RUN sudo -u gitlab_ci -H mkdir -p tmp/pids/
RUN sudo chmod -R u+rwX  tmp/pids/

# Install gems
RUN sudo -u gitlab_ci -H bundle install --without development test postgres --deployment


# following https://gitlab.com/gitlab-org/gitlab-ci/blob/master/doc/install/installation.md
