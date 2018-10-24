FROM ubuntu:18.04
MAINTAINER Lucas Mundim "lucas.mundim@gmail.com"

# Versions
ENV NGINX_VERSION 1.14.0
ENV NGINX_RTMP_VERSION 1.2.1

ENV DEBIAN_FRONTEND noninteractive
ENV PATH=/usr/local/nginx/sbin:$PATH

# create directories
RUN mkdir /src /config /logs /data /static

# update and upgrade packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
  build-essential \
  libpcre3-dev \
  libssl-dev \
  wget \
  zlib1g-dev \
  && apt-get clean

# get nginx source
RUN cd /src && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && tar zxf nginx-${NGINX_VERSION}.tar.gz && rm nginx-${NGINX_VERSION}.tar.gz

# get nginx-rtmp module
RUN cd /src && wget https://github.com/arut/nginx-rtmp-module/archive/v${NGINX_RTMP_VERSION}.tar.gz && tar zxf v${NGINX_RTMP_VERSION}.tar.gz && rm v${NGINX_RTMP_VERSION}.tar.gz

# configure nginx
RUN cd /src/nginx-${NGINX_VERSION} && ./configure --add-module=/src/nginx-rtmp-module-${NGINX_RTMP_VERSION} --conf-path=/config/nginx.conf

# compile nginx
RUN cd /src/nginx-${NGINX_VERSION} && make && make install

# cleanup
RUN rm -Rf /src

# Use same uid as boot2docker/docker-machine
RUN usermod -u 1000 www-data

ADD nginx.conf /config/nginx.conf
ADD static /static

EXPOSE 1935
EXPOSE 80

ENTRYPOINT "nginx"
