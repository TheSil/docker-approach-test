FROM ubuntu:latest as run_stage

# install only libraries necessary for running
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
  apt-get install --no-install-recommends -y \   
  libevent-dev flex libxml2-dev libopenmpi-dev nginx php-fpm php-curl ssh 
  
FROM run_stage as install_stage

# intstall additional dependencies required for install only
RUN apt-get install --no-install-recommends -y \   
  git g++ cmake bison libz-dev libevent-dev wget python3 ca-certificates libfl-dev

# approach0 ssh key
RUN mkdir /root/.ssh/
ADD id_rsa /root/.ssh/id_rsa
RUN \
 chmod 600 /root/.ssh/id_rsa && \
 echo "IdentityFile /root/.ssh/id_rsa" >> /etc/ssh/ssh_config && \  
 echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config 

# git commands (merge later)
RUN cd ~ && \
  git clone --depth=1 git@github.com:TheSil/a0-private.git
  
# Download and build Indri
RUN git clone https://github.com/approach0/fork-indri.git ~/indri
RUN cd ~/indri && ./configure && make

# Download CppJieba
RUN cd ~ && \
  wget 'https://github.com/yanyiwu/cppjieba/archive/v4.8.1.tar.gz' -O cppjieba.tar.gz && \
  mkdir -p ~/cppjieba && \
  tar -xzf cppjieba.tar.gz -C ~/cppjieba --strip-components=1 

# Fix for missing TERM issue when running non interactive shell (Docker)
ENV TERM xterm-256color

# Build Approach0
RUN cd ~/a0-private && \
  ./configure --indri-path=~/indri --jieba-path=~/cppjieba && \
  make
  
# copy output(s) to special folder for easier distribution later
RUN mkdir ~/built/ && \
  find . -name \*.out -exec cp {} ~/built/ \;
  
# next stage - start with cloned repository - without the ssh key or unnecessary packages
FROM run_stage
  
ADD ./approach0.conf /etc/nginx/sites-available/
RUN rm /etc/nginx/sites-enabled/default && \
  ln -s /etc/nginx/sites-available/approach0.conf /etc/nginx/sites-enabled/approach0.conf
  
COPY --from=install_stage /root/built /usr/bin
COPY --from=install_stage /root/a0-private/demo/web /var/www/html/
#COPY --from=install_stage /root/a0-private/indexerd/test-corpus /test-corpus/

ADD start_web.sh /usr/bin
RUN chmod +x /usr/bin/start_web.sh
CMD ["start_web.sh"]


