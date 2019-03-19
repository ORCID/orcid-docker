#!/bin/sh

source .env

if [ -f "${ORCID_SOURCE}/build.sh" ];then
    cd "${ORCID_SOURCE}" && \
    git pull origin master
else
    git clone "$GIT_REPO" "${ORCID_SOURCE}"
fi

cd "${ORCID_SOURCE}/" && \
git fetch -t && \
git checkout "$RELEASE_TAG" && \

if [ ! -f ~/.m2 ];then
    mkdir ~/.m2
fi
docker run --interactive --rm --workdir /home/orcidsource/orcid-nodejs -v ${ORCID_SOURCE}:/home/orcidsource -v $HOME/.m2:/root/.m2 maven:3-jdk-8mvn -P ci -Dnodejs.workingDirectory=/home/orcidsource/orcid-web/src/main/webapp/static/javascript/ng1Orcid clean compile package
docker run --interactive --rm --workdir /home/orcidsource -v ${ORCID_SOURCE}:/home/orcidsource -v $HOME/.m2:/root/.m2 maven:3-jdk-8 echo "https://${ORCID_HOSTNAME}:${ORCID_PORT}/orcid-web/static" > /home/orcidsource/orcid-web/src/main/resources/cdn_active_url.txt &&  mvn clean install -Dmaven.test.skip=true -Dlicense.skip=true
cp -v "${ORCID_SOURCE}/orcid-web/target/orcid-web.war" tomcat/webapps/
cp -v "${ORCID_SOURCE}/orcid-api-web/src/test/resources/orcid-server-keystore.jks" tomcat/webapps/
cp -v "${ORCID_SOURCE}/orcid-api-web/src/test/resources/orcid-server-truststore.jks" tomcat/webapps/
cp -v "${ORCID_SOURCE}/orcid-persistence/src/main/resources/staging-persistence.properties" tomcat/webapps/orcid.properties
echo "Done"


