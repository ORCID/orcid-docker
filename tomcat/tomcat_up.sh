#!/bin/sh

TOMCAT_HOME=/usr/local/tomcat

mkdir -p $TOMCAT_HOME/data/solr
cp ~/git/ORCID-Source/orcid-api-web/src/test/resources/orcid-server-keystore.jks $TOMCAT_HOME/conf/
cp ~/git/ORCID-Source/orcid-api-web/src/test/resources/orcid-server-truststore.jks $TOMCAT_HOME/conf/
cp ~/git/ORCID-Source/orcid-persistence/src/main/resources/staging-persistence.properties $TOMCAT_HOME/conf/orcid.properties
# or
#cp /tomcat/orcid.properties $TOMCAT_HOME/conf/
cp /tomcat/webapps/*.war $TOMCAT_HOME/webapps/
cp /tomcat/server.https.min.xml $TOMCAT_HOME/conf/server.xml
cp /tomcat/tomcat-users.min.xml $TOMCAT_HOME/conf/tomcat-users.xml
cp /tomcat/setenv.sh $TOMCAT_HOME/bin/

sed -i 's|localhost:5432|dev-db.orcid.org:5432|g' $TOMCAT_HOME/conf/orcid.properties

chown -R root:root $TOMCAT_HOME/conf
chmod +x $TOMCAT_HOME/bin/setenv.sh

echo 'CATALINA TOMCAT ready to start.'

catalina.sh run
