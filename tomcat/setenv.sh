#!/bin/sh

TOMCAT_HOME="/usr/local/tomcat"
ORCID_CONFIG="${TOMCAT_HOME}/conf/orcid.properties"

export JAVA_OPTS="-Dorg.orcid.config.file=file://$ORCID_CONFIG -Dsolr.solr.home=${TOMCAT_HOME}/webapp/solr"
