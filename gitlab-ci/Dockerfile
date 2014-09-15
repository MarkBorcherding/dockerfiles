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

# Install the database packages
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get install --yes mysql-server mysql-client libmysqlclient-dev

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

# Get Gitlab-ci
WORKDIR /home/gitlab_ci/
USER gitlab_ci
RUN git clone https://gitlab.com/gitlab-org/gitlab-ci.git

# Drop in config files for gitlab
WORKDIR /home/gitlab_ci/gitlab-ci
RUN git checkout 5-0-stable
ADD home/gitlab_ci/gitlab-ci/config/application.yml /home/gitlab_ci/gitlab-ci/config/application.yml
ADD home/gitlab_ci/gitlab-ci/config/unicorn.rb /home/gitlab_ci/gitlab-ci/config/unicorn.rb
ADD home/gitlab_ci/gitlab-ci/config/database.yml /home/gitlab_ci/gitlab-ci/config/database.yml

# Make sockets
RUN mkdir -p tmp/sockets/
RUN chmod -R u+rwX  tmp/sockets/
RUN mkdir -p tmp/pids/
RUN chmod -R u+rwX  tmp/pids/

ENV RAILS_ENV production

RUN bundle install --without development test postgres --deployment

USER root


# Add the database setup scripts
ADD etc/my_init.d/99_mysql_setup.sh /etc/my_init.d/99_mysql_setup.sh
RUN chmod +x /etc/my_init.d/99_mysql_setup.sh
ADD var/lib/mysql/setup/01_gitlab.sql /var/lib/mysql/setup/01_gitlab.sql
RUN mkdir -p /var/lib/mysql/mysql

# Add runit start up
RUN mkdir -p /etc/service/mysql
ADD etc/service/mysql/run /etc/service/mysql/run
RUN chmod +x /etc/service/mysql/run

# Add unicorn runit start up
RUN mkdir -p /etc/service/unicorn
ADD etc/service/unicorn/run /etc/service/unicorn/run
RUN chmod +x /etc/service/unicorn/run

# Add sidekiq runit start up
RUN mkdir -p /etc/service/sidekiq
ADD etc/service/sidekiq/run /etc/service/sidekiq/run
RUN chmod +x /etc/service/sidekiq/run

# Add the setup scripts
ADD etc/my_init.d/99a_setup_application_database.sh /etc/my_init.d/99a_setup_application_database.sh
RUN chmod +x /etc/my_init.d/99a_setup_application_database.sh

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN mkdir -p /home/gitlab_ci/gitlab-ci/log
RUN chown gitlab_ci /home/gitlab_ci/gitlab-ci/log


# Add Nginx
RUN apt-get install --yes --quiet nginx
RUN rm /etc/nginx/sites-enabled/default

RUN mkdir -p /etc/service/nginx
ADD etc/service/nginx/run /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run

ADD etc/nginx/sites-available/gitlab_ci /etc/nginx/sites-available/gitlab_ci
RUN ln -s /etc/nginx/sites-available/gitlab_ci /etc/nginx/sites-enabled/gitlab_ci

# Add SMTP Settings
# ADD home/gitlab_ci/gitlab-ci/config/initializers/smtp_settings.rb /home/gitlab_ci/gitlab-ci/config/initializers/smtp_settings.rb

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
WORKDIR /home/gitlab_ci/gitlab-ci

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
