# Deploy ORCID with DOCKER

This project uses docker containers to startup JavaEE PostgreSQL web application.

https://orcid.org/

The local environment will be available at

https://dev.orcid.org:8443/

## Install docker community edition

Follow install instructions at https://docs.docker.com/install/

* [Get Docker for Mac](https://download.docker.com/mac/stable/Docker.dmg)
* [Get Docker for Windows](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)
* [Get Docker for Linux](https://download.docker.com/linux/static/stable/aarch64/docker-18.03.1-ce.tgz)

## Assumptions

orcid docker and registry source is already available in your workspace

    mkdir ~/git && cd ~/git
    git clone https://github.com/ORCID/ORCID-Source.git
    git clone https://github.com/ORCID/orcid-docker.git

## Setup ORCID database first time

Reusing [postgres library](https://docs.docker.com/samples/library/postgres/)

    docker volume create orcid_data
    docker run --name orcid-postgres -e POSTGRES_PASSWORD=orcid -v `pwd`/orcid:/opt/initdb -v orcid_data:/var/lib/postgresql/9.5/main -d postgres:9.5
    docker exec -it orcid-postgres psql -U postgres -f /opt/initdb/orcid_dump.sql

> Download orcid_dump.sql from any sandbox machine

## Create orcid-web source ready container

Reusing [tomcat library](https://docs.docker.com/samples/library/tomcat/)

    # not required - just testing tomcat available at http://localhost:8888
    docker run --name tomcat_test --rm -p 8888:8080 -d tomcat:8.0-jre8
    docker stop tomcat_test

Build the base java web container

    cd ~/git/ORCID-Source
    echo 'https://dev.orcid.org:8443/static' > orcid-web/src/main/resources/cdn_active_url.txt
    mvn clean install package -Dmaven.test.skip=true -Dlicense.skip=true

Generate NG orcid js

    cd orcid-nodejs
    mvn -P ci -Dnodejs.workingDirectory=${HOME}/git/ORCID-Source/orcid-web/src/main/webapp/static/javascript/ng1Orcid clean install package

Package as war file all together

    cd ~/git/ORCID-Source/orcid-web
    mvn clean install package -Dmaven.test.skip=true -Dlicense.skip=true
    cp ~/git/ORCID-Source/orcid-web/target/orcid-web.war ~/git/orcid-docker/orcid/

Ready to build our custom orcid-web container

    cd ~/git/orcid-docker
    docker build --rm -t orcid/web .

If new container is available at `docker images` then we're ready to run orcid-web

    docker run --name orcid-web --rm --link orcid-postgres:db.orcid.org -d orcid/web

watch the app startup with

    docker logs -f orcid-web

## Build proxy server

Build shibboleth from source by creating a container with all required libraries

Download all libraries

    docker build --rm -t orcid/shibdev -f shibboleth/Dockerfile .

Create local persisted disk

    docker volume create shib_disk

Start shibboleth build

    docker run --rm -v shib_disk:/opt/shib_sp orcid/shibdev

Create nginx machine from orcid deb packages

    docker build --rm -t orcid/nginx -f nginx/Dockerfile .

    docker run --name orcid-proxy --rm -p 8080:80 -p 8443:443 -v shib_disk:/opt/shib_sp -v `pwd`/orcid:/orcid --link orcid-web:tomcat.orcid.org -e REGISTRY_IP_PORT=tomcat.orcid.org:8080 -d orcid/nginx

## Test web app

At this point a orcid-web instance should be available at http://localhost:8080/orcid-web and your docker catalog looks like next

    jperez@asusxubuntu:~/Templates/orcid-docker$ docker images
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    orcid/web           latest              2dfef66a9673        3 days ago          647MB
    orcid/nginx         latest              8416110096d7        3 days ago          495MB
    orcid/shibdev       latest              b2791b28e2e3        3 days ago          880MB
    nz/orcidhub         latest              b367d3e1b89e        13 days ago         445MB
    redis               latest              55cb7014c24f        2 weeks ago         83.4MB
    tomcat              8.0-jre8            4227b4397b18        4 weeks ago         467MB
    postgres            9.5                 71135c0ff9e7        4 weeks ago         234MB
    postgres            10.4                65bf726222e1        4 weeks ago         236MB
    ubuntu              14.04               578c3e61a98c        4 weeks ago         223MB
    centos              centos7             49f7960eb7e4        5 weeks ago         200MB
    jperez@asusxubuntu:~/Templates/orcid-docker$

Test the service with

    curl -I -k -L -H 'Host: dev.orcid.org' http://localhost:8080/orcid-web
