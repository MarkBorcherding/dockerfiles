FROM fooberry/ruby
MAINTAINER Mark Borcherding <markborcherding@gmail.com>

# Get the dependencies
RUN apt-get update
RUN apt-get --quiet --yes install libpcre3 libpcre3-dev

# Get Nginx source
WORKDIR /tmp
RUN wget http://nginx.org/download/nginx-1.7.0.tar.gz
RUN mkdir -p /usr/local/src/nginx
RUN tar -xzf nginx-1.7.0.tar.gz -C /usr/local/src/nginx/

# Build Nginx
WORKDIR /usr/local/src/nginx/nginx-1.7.0
RUN ./configure
RUN make install
ADD nginx.init.d /etc/init.d/nginx
RUN chmod +x /etc/init.d/nginx

