mkdir .\deploy\tmp
docker create --name approach0_build_cont approach0_build /bin/sh -c "chmod +x /build.sh;/build.sh;"
docker cp ./guest/build.sh approach0_build_cont:/build.sh 
docker start -i approach0_build_cont 
docker cp approach0_build_cont:/root/built/ ./deploy/tmp/
docker cp approach0_build_cont:/root/a0-private/demo/web/ ./deploy/tmp/
docker rm approach0_build_cont
