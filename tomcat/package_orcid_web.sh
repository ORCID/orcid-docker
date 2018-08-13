#!/bin/sh

ORCID_HOSTNAME="dev.orcid.org"
ORCID_PORT="8443"
ORCID_SOURCE="${HOME}/git/ORCID-Source"

echo 'https://${ORCID_HOSTNAME}:${ORCID_PORT}/static' > ${ORCID_SOURCE}/orcid-web/src/main/resources/cdn_active_url.txt

cd "${ORCID_SOURCE}/"
mvn clean install -Dmaven.test.skip=true -Dlicense.skip=true

cd "${ORCID_SOURCE}/orcid-nodejs"
mvn -P ci -Dnodejs.workingDirectory=${ORCID_SOURCE}orcid-web/src/main/webapp/static/javascript/ng1Orcid clean install package

cd "${ORCID_SOURCE}/orcid-web"
mvn clean install package -Dmaven.test.skip=true -Dlicense.skip=true

cp -v "${ORCID_SOURCE}/orcid-web/target/orcid-web.war" "${HOME}/git/orcid-docker/tomcat/webapps/"
