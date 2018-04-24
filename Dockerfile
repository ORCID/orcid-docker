FROM ubuntu:14.04

MAINTAINER Jeff P. <jeff@siccr.com>

ENV LANG en_US.utf8

ADD https://apt.puppetlabs.com/puppetlabs-release-trusty.deb /opt/puppetlabs-release-trusty.deb

COPY init.pp /opt/

RUN dpkg -i /opt/puppetlabs-release-trusty.deb

RUN apt-get -q -y update && apt-get -q -y install puppet git-core && apt-mark -q hold puppet puppet-common

COPY puppet.conf /etc/puppet/puppet.conf

RUN ln -s /etc/hiera.yaml /etc/puppet/hiera.yaml

RUN puppet module install puppetlabs-stdlib

RUN groupadd -r orcid_tomcat --gid=7006 && useradd -m -r -g orcid_tomcat --uid=7006 orcid_tomcat

VOLUME ~/git/registry_vagrant/puppet:/opt/orcid-puppet

RUN puppet apply --environment qa --modulepath /opt/orcid-puppet/modules:/etc/puppet/modules /opt/init.pp

RUN apt-get -y autoremove

USER orcid_tomcat

#WORKDIR /home/orcid_tomcat

RUN whoami && ls -l ~

#CMD ["python", "~/bin/scripts/deployment/deploy-app.py", "--release"', "$ORCID_RELEASE", "web"]

#ENTRYPOINT ["~/bin/tomcat/bin/startup.sh"]

EXPOSE 8080
