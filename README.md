# docker-approach-test
Test repository for trying to build and run Approach0 in docker container based on ubuntu image. My main focus is to run on Windows host machine, so you might find some ugly .bat files in the repo.

# Build

The docker image requires you have an ssh key generated and allowed and stored next to the docker file (since the Approach0 repository is a private one). Such key pair can be generated for example using

`ssh-keygen -q -t rsa -N "" -f id_rsa`


