docker create --name approach0_web -p 80:80 -p 8934:8934 approach0_deploy /bin/sh -c "chmod +x /start_web.sh;/start_web.sh;"
docker cp ./guest/start_web.sh approach0_web:/start_web.sh
docker start -i approach0_web
