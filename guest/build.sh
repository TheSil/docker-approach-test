#!/bin/bash
cd ~ 
git clone --depth=1 git@github.com:TheSil/a0-private.git
cd ~/a0-private 
./configure --indri-path=~/indri --jieba-path=~/cppjieba 
make
mkdir ~/built/
find . -name \*.out -exec cp {} ~/built/ \;
cd ~/a0-private/demo/web
chmod +x ./pack.sh
./pack.sh
 