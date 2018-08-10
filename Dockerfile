FROM tomcat:8.0-jre8

LABEL maintainer="Jeff P. <jeff@siccr.com>"

ENV LANG en_US.utf8

ENV TOMCAT_HOME /usr/local/tomcat

COPY orcid/tomcat_up.sh /usr/bin/reconfigure.sh

RUN chmod +x /usr/bin/reconfigure.sh

CMD ["/usr/bin/reconfigure.sh"]

EXPOSE 8888

CMD ["catalina.sh", "run"]
