FROM ubuntu:14.04

MAINTAINER Jeff P. <jeff@siccr.com>

ADD https://apt.puppetlabs.com/puppetlabs-release-trusty.deb /opt/puppetlabs-release-trusty.deb

COPY init.pp /opt/

RUN dpkg -i /opt/puppetlabs-release-trusty.deb

RUN apt-get -q -y update && apt-get -q -y install puppet git-core && apt-mark -q hold puppet puppet-common 

COPY puppet.conf /etc/puppet/puppet.conf

RUN git clone https://github.com/ORCID/registry_vagrant.git /opt/orcid

RUN puppet apply --environment qa --modulepath /opt/orcid/puppet/modules /opt/init.pp

RUN apt-get -y autoremove

