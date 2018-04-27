FROM orcid/puppet

MAINTAINER Jeff P. <jeff@siccr.com>

ENV LANG en_US.utf8

COPY puppet_modules/orcid/manifests/*.pp /opt/

COPY puppet_modules/orcid/files/web_start.sh /usr/bin/

RUN chmod +x /usr/bin/web_start.sh

RUN puppet apply --environment qa --modulepath /opt/orcid-puppet/modules:/etc/puppet/modules /opt/orcid_java.pp

RUN puppet apply --environment qa --modulepath /opt/orcid-puppet/modules:/etc/puppet/modules /opt/orcid_maven.pp

# RUN groupadd -r orcid_tomcat --gid=7006 && useradd -m -r -g orcid_tomcat --uid=7006 orcid_tomcat && mkdir /home/orcid_tomcat/git
# RUN puppet apply --environment qa --modulepath /opt/orcid-puppet/modules:/etc/puppet/modules /opt/orcid_tomcat.pp
# RUN chown -R 7006:7006 /opt/orcid-* /home/orcid_tomcat
# VOLUME ["/home/orcid_tomcat/tomcat/logs", "/home/orcid_tomcat/tomcat/conf", "/home/orcid_tomcat/tomcat/data"]
# EXPOSE 8080
# CMD ["/bin/sh", "puppet_modules/orcid/files/web_start.sh $ORCID_RELEASE"]
