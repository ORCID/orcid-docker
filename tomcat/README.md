# Manual build of containers (Optional)

#### Build war files inside container

    cd ~/git/orcid-docker
    source .env
    docker run --interactive --rm --workdir /home/orcidsource/orcid-nodejs -v ${ORCID_SOURCE}:/home/orcidsource -v $HOME/.m2:/root/.m2 maven:3-jdk-8mvn -P ci -Dnodejs.workingDirectory=/home/orcidsource/orcid-web/src/main/webapp/static/javascript/ng1Orcid clean compile package
    docker run --interactive --rm --workdir /home/orcidsource -v ${ORCID_SOURCE}:/home/orcidsource -v $HOME/.m2:/root/.m2 maven:3-jdk-8 echo "https://${ORCID_HOSTNAME}:${ORCID_PORT}/orcid-web/static" > /home/orcidsource/orcid-web/src/main/resources/cdn_active_url.txt &&  mvn clean install -Dmaven.test.skip=true -Dlicense.skip=true
    cp -v "${ORCID_SOURCE}/orcid-web/target/orcid-web.war" tomcat/webapps/
    cp -v "${ORCID_SOURCE}/orcid-api-web/src/test/resources/orcid-server-keystore.jks" tomcat/webapps/
    cp -v "${ORCID_SOURCE}/orcid-api-web/src/test/resources/orcid-server-truststore.jks" tomcat/webapps/
    cp -v "${ORCID_SOURCE}/orcid-persistence/src/main/resources/staging-persistence.properties" tomcat/webapps/orcid.properties

#### Setup ORCID database

Reusing [postgres library](https://docs.docker.com/samples/library/postgres/), create local volume to persist orcid data

    docker volume create orcid_data
    docker run --name orcid-postgres \
    -v $(pwd)/tomcat/initdb:/docker-entrypoint-initdb.d \
    -v orcid_data:/var/lib/postgresql/9.5/main \
    -d postgres:9.5

> Every sql files at /tomcat/initdb/* is going to be run as `psql -U postgres -f /opt/initdb/orcid_dump.sql`, Download orcid_dump.sql from any sandbox machine

#### Create orcid-web source ready container

Build the base java web container

    cd ~/git/ORCID-Source
    mvn clean install package -Dmaven.test.skip=true -Dlicense.skip=true

Ready to build our custom orcid-web container

    cd ~/git/orcid-docker/tomcat
    docker build --rm -t orcid/web -f ./tomcat/Dockerfile .

If new container is available at `docker images` then we're ready to run orcid-web

    docker run --name orcid-web \
    --rm -v `pwd`/orcid:/orcid \
    --link orcid-postgres:dev-db.orcid.org \
    -d orcid/web

watch the app startup with

    docker logs -f orcid-web

