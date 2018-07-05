# Reuse existing containers

docker files to build orcid web app

## Install docker community edition

Follow install instructions at https://docs.docker.com/install/

* [Get Docker for Mac](https://download.docker.com/mac/stable/Docker.dmg)
* [Get Docker for Windows](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)

## Assumptions

registry vagrant repository is already available in your workspace

    mkdir ~/git && cd ~/git
    git clone https://github.com/ORCID/orcid-docker.git
    git clone https://github.com/ORCID/ORCID-Source.git

## Setup ORCID database first time

Reusing [postgres library](https://docs.docker.com/samples/library/postgres/)

    docker volume create orcid_data
    docker run --name orcid-postgres --rm -e POSTGRES_PASSWORD=orcid -v `pwd`:/opt/initdb -v orcid_data:/var/lib/postgresql/9.5/main -d postgres:9.5
    docker exec -it orcid-postgres psql -U postgres -f /opt/initdb/orcid_db.sql

Reusing [tomcat library](https://docs.docker.com/samples/library/tomcat/)

    # not required - just testing tomcat available at http://localhost:8080
    docker run -it --rm -p 8080:8080 tomcat:8.0-jre8

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
    cd ~/git/orcid-docker

Ready to build our suctom orcid-web container

    docker build --rm -t orcid/web .

If new container is available at `docker images` then we're ready to run orcid-web

    docker run -d -p 8080:8080 --name orcid-web --rm --link orcid-postgres:orcid-db orcid/web

or with volume

    docker run -d -p 8080:8080 --name orcid-web --rm --link orcid-postgres:orcid-db -v ~/Templates/ORCID-Source:/opt/ORCID-Source orcid/web

watch the app startup with

    docker logs -f orcid-web

at this point a orcid-web instance should be available at http://localhost:8080/orcid-web

    curl -I -k -L http://localhost:8080/orcid-web







