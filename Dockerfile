FROM ubuntu:14.04

MAINTAINER Jeff P. <jeff@siccr.com>

ENV LANG en_US.utf8

ADD https://apt.puppetlabs.com/puppetlabs-release-trusty.deb /opt/puppetlabs-release-trusty.deb

RUN dpkg -i /opt/puppetlabs-release-trusty.deb

RUN apt-get -q -y update && apt-get -q -y install puppet && apt-mark -q hold puppet puppet-common

COPY puppet_modules/orcid/files/puppet.conf /etc/puppet/puppet.conf

RUN ln -s /etc/hiera.yaml /etc/puppet/hiera.yaml

RUN puppet module install puppetlabs-stdlib

