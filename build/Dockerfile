FROM ubuntu:latest

# install libraries necessary for running
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
  apt-get install --no-install-recommends -y \   
  libevent-dev flex libxml2-dev libopenmpi-dev nginx php-fpm php-curl ssh libfl2 tmux openmpi-bin 

# intstall additional dependencies required for install only
RUN apt-get install --no-install-recommends -y \   
  git g++ cmake bison libz-dev libevent-dev wget python3 ca-certificates libfl-dev uglifyjs

# Download and build Indri
RUN git clone --depth=1 https://github.com/approach0/fork-indri.git ~/indri
RUN cd ~/indri && ./configure && make

# Download CppJieba
RUN cd ~ && \
  wget 'https://github.com/yanyiwu/cppjieba/archive/v4.8.1.tar.gz' -O cppjieba.tar.gz && \
  mkdir -p ~/cppjieba && \
  tar -xzf cppjieba.tar.gz -C ~/cppjieba --strip-components=1
  
# Fix for missing TERM issue when running non interactive shell (Docker)
ENV TERM xterm-256color

# approach0 ssh key
RUN mkdir /root/.ssh/
ADD id_rsa /root/.ssh/id_rsa
RUN \
 chmod 600 /root/.ssh/id_rsa && \
 echo "IdentityFile /root/.ssh/id_rsa" >> /etc/ssh/ssh_config && \  
 echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config 
 
CMD ["/bin/bash"]
