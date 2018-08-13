#!/bin/sh

TOMCAT_HOME=/usr/local/tomcat

mkdir -p $TOMCAT_HOME/data/solr

cp /orcid/webapps/*.war $TOMCAT_HOME/webapps/
cp /orcid/server.https.min.xml $TOMCAT_HOME/conf/server.xml
cp /orcid/tomcat-users.min.xml $TOMCAT_HOME/conf/tomcat-users.xml
cp /orcid/setenv.sh $TOMCAT_HOME/bin/
#cp /orcid/orcid.properties $TOMCAT_HOME/conf/
cp /orcid_source/orcid-persistence/src/main/resources/staging-persistence.properties $TOMCAT_HOME/conf/orcid.properties
sed -i 's|localhost:5432|dev-db.orcid.org:5432|g' $TOMCAT_HOME/conf/orcid.properties
chmod +x $TOMCAT_HOME/bin/setenv.sh

echo 'CATALINA TOMCAT ready to start.'

catalina.sh run
