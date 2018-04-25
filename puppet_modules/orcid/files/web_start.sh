#!/bin/sh

TOMCAT_HOME="/home/orcid_tomcat/tomcat"
ORCID_SOURCE="/home/orcid_tomcat/git/ORCID-Source"
ORCID_WEB_WAR="$ORCID_SOURCE/orcid-web/target/orcid-web.war"

if [ -f "$ORCID_WEB_WAR" ];then
    cp -v "$ORCID_WEB_WAR" "$TOMCAT_HOME/webapps/"
fi
#cp -v $ORCID_SOURCE/orcid-api-web/target/orcid-api-web.war $TOMCAT_HOME/webapps/
#cp -v $ORCID_SOURCE/orcid-pub-web/target/orcid-pub-web.war $TOMCAT_HOME/webapps/

$TOMCAT_HOME/bin/catalina.sh run


