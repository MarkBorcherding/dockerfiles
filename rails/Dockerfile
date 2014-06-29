FROM fooberry/ruby
MAINTAINER Mark Borcherding <markborcherding@gmail.com>

# Get the dependencies
RUN apt-get update &&\
    apt-get --quiet --yes install libpcre3 libpcre3-dev

# Get Nginx source
RUN cd /tmp &&\
    wget http://nginx.org/download/nginx-1.7.0.tar.gz &&\
    mkdir -p /usr/local/src/nginx &&\
    tar -xzf nginx-1.7.0.tar.gz -C /usr/local/src/nginx/

# Build Nginx
RUN cd /usr/local/src/nginx/nginx-1.7.0 &&\
    ./configure &&\
    make install

# Add the init.d script
ADD nginx.init.d /etc/init.d/nginx
RUN chmod +x /etc/init.d/nginx

