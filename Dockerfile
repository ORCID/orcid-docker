FROM tomcat:8.0-jre8

LABEL maintainer="Jeff P. <jeff@siccr.com>"

ENV LANG en_US.utf8

ENV TOMCAT_HOME /usr/local/tomcat

RUN mkdir -p $TOMCAT_HOME/data/solr

COPY orcid/orcid-web.war $TOMCAT_HOME/webapps/

COPY orcid/server.min.xml $TOMCAT_HOME/conf/server.xml

COPY orcid/tomcat-users.min.xml $TOMCAT_HOME/conf/tomcat-users.xml

COPY orcid/setenv.sh $TOMCAT_HOME/bin/

RUN chmod +x $TOMCAT_HOME/bin/setenv.sh

COPY orcid/orcid.properties $TOMCAT_HOME/conf/
