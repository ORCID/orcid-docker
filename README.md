# orcid-docker

docker files to build orcid web app

## install docker community edition

Follow install instructions at https://docs.docker.com/install/

* [Get Docker for Mac](https://download.docker.com/mac/stable/Docker.dmg)
* [Get Docker for Windows](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)

## Assumptions

    mkdir ~/git && cd ~/git
    git clone https://github.com/ORCID/registry_vagrant.git

## build the base orcid web image

    git clone git@github.com:ORCID/orcid-docker.git

create custom image

    docker build \
    -f orcid-docker/Dockerfile \
    -t localhost/orcid-web:v1 .

## start web container

start up  the web context

    docker run \
    -v ~/git/ORCID-Source:/home/orcid_tomcat/git/ORCID-Source \
    -v ~/.m2:/home/orcid_tomcat/.m2 \
    -e ORCID_RELEASE=release-1.222.4 \
    -u orcid_tomcat \
    --name orcid-web \
    localhost/orcid-web:v1

> update release-1.222.4 with required release tag from git repo

at this point a orcid-web instance should be available at http://localhost:8080/orcid-web

    curl -I -k -L http://localhost:8080/orcid-web
