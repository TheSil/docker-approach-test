#!/bin/bash
mkdir /indexed
indexerd.out -o /indexed/ &
#searchd.out -i /indexed/ &
#service php7.2-fpm start && nginx -g "daemon off;"
