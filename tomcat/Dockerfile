FROM tomcat:8.0-jre8

#LABEL maintainer=""
MAINTAINER "Jeff P. <jeff@siccr.com>"

ENV LANG en_US.utf8

ENV TOMCAT_HOME /usr/local/tomcat

COPY ./tomcat_up.sh /usr/bin/tomcat_up.sh

RUN chmod +x /usr/bin/tomcat_up.sh

CMD ["/usr/bin/tomcat_up.sh"]

CMD ["tomcat_up.sh"]

EXPOSE 8443
