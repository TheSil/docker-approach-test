# docker-approach-test
Test repository for trying to build and run Approach0 in docker container based on ubuntu image. My main focus is to run on Windows host machine, so you might find some ugly .bat files in the repo.

# Build

The docker image requires you have an ssh key generated and allowed and stored next to the docker file (since the Approach0 repository is a private one). Such key pair can be generated for example using

`ssh-keygen -q -t rsa -N "" -f id_rsa`

# TODO

* add repository link and key link as an arguments to the build process
* find some way to make it less prone to problems in the future when new version of php-fpm gets released (remove specific version dependencies or enforce it everywhere)
* make indexing work (mounted fs from Windows does not seem to work well)
* make searchd work (gives buffer overflow)