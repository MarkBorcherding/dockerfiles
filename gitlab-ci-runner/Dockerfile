FROM phusion/baseimage:0.9.13
MAINTAINER Mark Borcherding <MarkBorcherding@gmail.com>

# Forked from https://github.com/gitlabhq/gitlab-ci-runner/blob/master/Dockerfile

# This script will start a runner in a docker container.
#
# First build the container and give a name to the resulting image:
# docker build -t gitlabhq/gitlab-ci-runner github.com/gitlabhq/gitlab-ci-runner
#
# Then set the environment variables and run the gitlab-ci-runner in the container:
# docker run -e CI_SERVER_URL=https://ci.example.com -e REGISTRATION_TOKEN=replaceme -e HOME=/root -e GITLAB_SERVER_FQDN=gitlab.example.com gitlabhq/gitlab-ci-runner
#
# After you start the runner you can send it to the background with ctrl-z
# The new runner should show up in the GitLab CI interface on /runners
#
# You can start an interactive session to test new commands with:
# docker run -e CI_SERVER_URL=https://ci.example.com -e REGISTRATION_TOKEN=replaceme -e HOME=/root -i -t gitlabhq/gitlab-ci-runner:latest /bin/bash
#
# If you ever want to freshly rebuild the runner please use:
# docker build -no-cache -t gitlabhq/gitlab-ci-runner github.com/gitlabhq/gitlab-ci-runner

# Update your packages and install the ones that are needed to compile Ruby
RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt-get install --yes --quiet \
            build-essential \
            curl \
            git \
            libcurl4-openssl-dev \
            libicu-dev \
            libreadline6-dev \
            libssl-dev \
            libxml2-dev \
            libxslt-dev \
            libyaml-dev \
            openssh-server \
            patch \
            zlib1g-dev

# Install ruby-build
RUN cd /usr/local/src &&\
    git clone https://github.com/sstephenson/ruby-build.git &&\
    cd ruby-build &&\
    ./install.sh

# Install Ruby
RUN ruby-build 2.1.2 /usr/local

RUN gem update --system && \
    gem install bundler

# Set an utf-8 locale
RUN echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/default/locale
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

# Prepare a known host file for non-interactive ssh connections
RUN mkdir -p /root/.ssh && \
    touch /root/.ssh/known_hosts

# Install the runner
RUN curl --silent -L https://gitlab.com/gitlab-org/gitlab-ci-runner/repository/archive.tar.gz | tar xz
RUN cd gitlab-ci-runner.git && \
    bundle install --deployment

RUN apt-get install --yes --quiet redis-server

# Install mysql without root password
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install --yes --quiet  \
      libmysqlclient-dev \
      mysql-client  \
      mysql-server

RUN apt-get install --yes --quiet libqtwebkit-dev         # test with capybara
RUN apt-get install --yes --quiet sqlite3 libsqlite3-dev  # sqlite is the default datastore

# When the image is started add the remote server key, set up the runner and run it
WORKDIR /gitlab-ci-runner.git

# Add runit mysql start up
RUN mkdir -p /etc/service/mysql
ADD etc/service/mysql/run /etc/service/mysql/run
RUN chmod +x /etc/service/mysql/run

# Add runit redis start up
RUN mkdir -p /etc/service/redis
ADD etc/service/redis/run /etc/service/redis/run
RUN chmod +x /etc/service/redis/run

# Add runit gitlab-ci-runner start up
RUN mkdir -p /etc/service/gitlab-ci-runner
ADD etc/service/gitlab-ci-runner/run /etc/service/gitlab-ci-runner/run
RUN chmod +x /etc/service/gitlab-ci-runner/run
