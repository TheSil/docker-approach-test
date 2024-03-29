# docker-approach-test
Test repository for trying to build and run Approach0 in docker container based on ubuntu image. My main focus is to run on Windows host machine, so you might find some ugly .bat files in the repo.

This repository contains two docker images, one for build environment and second for deploy environment.

## Make approach0_build:latest
This image can be used as a build environment for Approach0. First you need to make the image itself. You need to repeat this step only if something in the build environment changes (e.g. new version of a library needs to be used).

The build image requires you have an ssh key generated and allowed and stored next to the docker file (since the Approach0 repository is a private one). Such key pair can be generated for example using

``` 
ssh-keygen -q -t rsa -N "" -f ./build/id_rsa
```

The actual build image can be made by

``` 
docker build -t approach0_build:latest ./build
```

## Build Approach0 itself 

You can use the approach0_build image to build the latest Approach0, use/modify the build.sh as required (e.g. link to your fork), and then just execute (for win users in `build_approach.bat`):

```
mkdir .\deploy\tmp
docker create --name approach0_build_cont approach0_build /bin/sh -c "chmod +x /build.sh;/build.sh;"
docker cp build.sh approach0_build_cont:/build.sh 
docker start -i approach0_build_cont 
docker cp approach0_build_cont:/root/built/ ./deploy/tmp/
docker cp approach0_build_cont:/root/a0-private/demo/web/ ./deploy/tmp/
docker rm approach0_build_cont
```

This will use clean instance of the build image and execute the build script accordingly, then moving the output of the container and removing it.


## Make approach0_deploy:latest
This image can be used as a deployment environment for Approach0, based on already built Approach0. The image can be made by (for win users in `make_deploy_image.bat`)

``` 
docker build -t approach0_deploy:latest ./deploy/
```

## Run web container

Work in progress... Only running web without the search daemon.

In order to run the approach web in its container (for win users in `web_start.bat`):

```
docker create --name approach0_web -p 80:80 approach0_deploy /bin/sh -c "chmod +x /start_web.sh;/start_web.sh;"
docker cp ./guest/start_web.sh approach0_web:/start_web.sh
docker start -i approach0_web
```

Then it should be possible to see the website using http://localhost/

To stop and remove the container (for win users in `web_stop.bat`):

```
docker stop approach0_web
docker rm approach0_web
```

## Run indexer and search daemon containers

TODO (not tested) idea is:
- start indexer container with configurable input (to be able to persist index outside of the container)
- start search daemon with configurable index input (copy the output from indexer container before if needed)

Then we can just restart the search daemon if index needs an update.

## TODO

* add repository link and key link as an arguments to the build process
* find some way to make it less prone to problems in the future when new version of php-fpm gets released (remove specific version dependencies or enforce it everywhere)
* make indexing work (mounted fs from Windows does not seem to work well)
* make searchd work (gives buffer overflow)