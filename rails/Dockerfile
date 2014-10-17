FROM fooberry/ruby
MAINTAINER Mark Borcherding <markborcherding@gmail.com>


# Install nginx
RUN apt-add-repository ppa:nginx/development
RUN apt-get update && \
    apt-get install --quiet --yes nginx

RUN mkdir -p /etc/service/nginx
ADD nginx/run /etc/service/nginx/run

ADD syslog-ng/nginx.conf /etc/syslog-ng/conf.d/nginx.conf
ADD nginx/logging.conf /etc/nginx/conf.d/logging.conf
