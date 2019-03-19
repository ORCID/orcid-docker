#!/bin/sh

ORCID_DOCKER=$(pwd)
. "$ORCID_DOCKER/.env"

if [ -f "${ORCID_SOURCE}/pom.xml" ];then
    cd "${ORCID_SOURCE}" && \
    git pull origin master
else
    git clone "$GIT_REPO" "${ORCID_SOURCE}"
fi

cd "${ORCID_SOURCE}/" && \
git fetch -t && \
git checkout "$RELEASE_TAG"

if [ ! -f "$HOME/.m2" ];then
    mkdir "$HOME/.m2"
fi

cd "$ORCID_DOCKER" && \
docker run --interactive --rm --workdir /home/orcidsource/orcid-nodejs -v ${ORCID_SOURCE}:/home/orcidsource -v $HOME/.m2:/root/.m2 maven:3-jdk-8 mvn -P ci -Dnodejs.workingDirectory=/home/orcidsource/orcid-web/src/main/webapp/static/javascript/ng1Orcid clean compile package && \
echo "https://${ORCID_HOSTNAME}:${ORCID_PORT}/orcid-web/static" > ${ORCID_SOURCE}/orcid-web/src/main/resources/cdn_active_url.txt && \
docker run --interactive --rm --workdir /home/orcidsource -v ${ORCID_SOURCE}:/home/orcidsource -v $HOME/.m2:/root/.m2 maven:3-jdk-8 mvn clean install -Dmaven.test.skip=true -Dlicense.skip=true

cp -v "${ORCID_SOURCE}/orcid-web/target/orcid-web.war" $(pwd)/tomcat/webapps/
cp -v "${ORCID_SOURCE}/orcid-api-web/src/test/resources/orcid-server-keystore.jks" $(pwd)/tomcat/webapps/
cp -v "${ORCID_SOURCE}/orcid-api-web/src/test/resources/orcid-server-truststore.jks" $(pwd)/tomcat/webapps/
cp -v "${ORCID_SOURCE}/orcid-persistence/src/main/resources/staging-persistence.properties" $(pwd)/tomcat/webapps/orcid.properties

ls -ltha $(pwd)/tomcat/webapps/
echo "Done"


