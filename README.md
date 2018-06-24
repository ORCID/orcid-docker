# orcid-docker

docker files to build orcid web app

## install docker community edition

Follow install instructions at https://docs.docker.com/install/

* [Get Docker for Mac](https://download.docker.com/mac/stable/Docker.dmg)
* [Get Docker for Windows](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)

## assumptions

registry vagrant repository is already available in your workspace

    mkdir ~/git && cd ~/git
    git clone https://github.com/ORCID/registry_vagrant.git
    git clone https://github.com/ORCID/ORCID-Source.git

## build the base orcid web image

    git clone git@github.com:ORCID/orcid-docker.git

create the base docker puppet ready image

    cd orcid-docker
    docker build -t orcid/puppet .

build the base java web container

    docker build -t orcid/web -f web.Dockerfile .

build database skeleton with persistent volume

    docker build -t orcid/pg:v1 f postgresql.Dockerfile .

or with predefined volume

    docker volume create orcid_data
    docker build -t orcid/pg:v1 -f postgresql.Dockerfile -v orcid_data:/var/lib/postgresql/9.5/main .

## start web container

initialize database

    docker run --rm -dP -p 5432:5432 \
    -v orcid_data:/var/lib/postgresql/9.5/main \
    -u postgres \
    --name orcid-db \
    orcid/pg:v1

start up  the web context

    docker run --rm -dP -p 8080:8080 \
    -v ~/git/ORCID-Source:/home/orcid_tomcat/git/ORCID-Source \
    -v ~/.m2:/home/orcid_tomcat/.m2 \
    -e ORCID_RELEASE=release-1.222.4 \
    -u orcid_tomcat \
    --name orcid-web \
    orcid/web

> update release-1.222.4 with required release tag from git repo

at this point a orcid-web instance should be available at http://localhost:8080/orcid-web

    curl -I -k -L http://localhost:8080/orcid-web


confirm

    orcid_tomcat@docker1test:~/git/ORCID-Source$ mvn -Dmaven.test.skip=true -DskipTest clean install
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time: 03:19 min
    [INFO] Finished at: 2018-04-27T15:54:04+00:00
    [INFO] Final Memory: 265M/1116M
    [INFO] ------------------------------------------------------------------------
    orcid_tomcat@docker1test:~/git/ORCID-Source$ find . -name *.war
    ./orcid-message-listener/target/orcid-message-listener.war
    ./orcid-api-web/target/orcid-api-web.war
    ./orcid-integration-test/target/orcid-integration-test-1.1.5-SNAPSHOT.war
    ./orcid-internal-api/target/orcid-internal-api.war
    ./orcid-solr-web/target/orcid-solr-web.war
    ./orcid-scheduler-web/target/orcid-scheduler-web.war
    ./orcid-pub-web/target/orcid-pub-web.war
    ./orcid-web/target/orcid-web.war
    ./orcid-activities-indexer/target/orcid-activities-indexer.war
    ./orcid-activemq/target/orcid-activemq.war









