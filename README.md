# Reuse existing containers

docker files to build orcid web app

## Install docker community edition

Follow install instructions at https://docs.docker.com/install/

* [Get Docker for Mac](https://download.docker.com/mac/stable/Docker.dmg)
* [Get Docker for Windows](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)

## Assumptions

orcid docker and registry source is already available in your workspace

    mkdir ~/git && cd ~/git
    git clone https://github.com/ORCID/orcid-docker.git
    git clone https://github.com/ORCID/ORCID-Source.git

## Setup ORCID database first time

Reusing [postgres library](https://docs.docker.com/samples/library/postgres/)

    docker volume create orcid_data
    docker run --name orcid-postgres --rm -e POSTGRES_PASSWORD=orcid -v `pwd`/orcid:/opt/initdb -v orcid_data:/var/lib/postgresql/9.5/main -d postgres:9.5
    docker exec -it orcid-postgres psql -U postgres -f /opt/initdb/orcid_dump.sql

> Download orcid_dump.sql from any sandbox machine

Reusing [tomcat library](https://docs.docker.com/samples/library/tomcat/)

    # not required - just testing tomcat available at http://localhost:8888
    docker run --name tomcat_test --rm -p 8888:8080 -d tomcat:8.0-jre8
    docker stop tomcat_test

Build the base java web container

    cd ~/git/ORCID-Source
    echo 'http://localhost:8080/orcid-web/static' > orcid-web/src/main/resources/cdn_active_url.txt
    mvn clean install package -Dmaven.test.skip=true -Dlicense.skip=true

Generate NG orcid js

    cd orcid-nodejs
    mvn -P ci -Dnodejs.workingDirectory=~/git/ORCID-Source/orcid-web/src/main/webapp/static/javascript/ng1Orcid clean install package

Package as war file all together

    cd ~/git/ORCID-Source/orcid-web
    mvn clean install package -Dmaven.test.skip=true -Dlicense.skip=true
    cp ~/git/ORCID-Source/orcid-web/target/orcid-web.war ~/git/orcid-docker/orcid/

Ready to build our suctom orcid-web container

    cd ~/git/orcid-docker
    docker build --rm -t orcid/web .

If new container is available at `docker images` then we're ready to run orcid-web

    docker run -d --name orcid-web --rm --link orcid-postgres:db.orcid.org orcid/web

or with volume

    docker run -d --name orcid-web --rm --link orcid-postgres:db.orcid.org -v ~/Templates/ORCID-Source:/opt/ORCID-Source orcid/web

watch the app startup with

    docker logs -f orcid-web

at this point a orcid-web instance should be available at http://localhost:8080/orcid-web

    curl -I -k -L http://localhost:8080/orcid-web

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

    docker run --rm -d -p 8080:80 -v shib_disk:/opt/shib_sp --link orcid-web:dev.orcid.org -e REGISTRY_IP_PORT=dev.orcid.org:8080 orcid/nginx


.




















