FROM ubuntu:latest

# install libraries necessary for running
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
  apt-get install --no-install-recommends -y \   
  libevent-dev flex libxml2-dev libopenmpi-dev nginx php-fpm php-curl ssh libfl2 tmux openmpi-bin 
  
ADD ./approach0.conf /etc/nginx/sites-available/
RUN rm /etc/nginx/sites-enabled/default && \
  ln -s /etc/nginx/sites-available/approach0.conf /etc/nginx/sites-enabled/approach0.conf
  
ADD ./tmp/built /usr/bin
ADD ./tmp/web /var/www/html/

