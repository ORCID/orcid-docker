FROM ubuntu:14.04

LABEL maintainer="Jeff P. <jeff@siccr.com>"

ENV LANG en_US.utf8

ADD https://shibboleth.net/downloads/service-provider/2.5.4/shibboleth-sp-2.5.4.tar.gz /opt/

RUN tar xzvf /opt/shibboleth-sp-2.5.4.tar.gz -C /opt/

RUN apt-get update && \
    apt-get install -y liblog4cpp5-dev \
    libxerces-c-dev \
    libxml-security-c-dev \
    libpcre3-dev \
    autotools-dev \
    libexpat1-dev \
    libgd-dev \
    libgeoip-dev \
    liblua5.1-0-dev \
    libmhash-dev \
    libpam0g-dev \
    libperl-dev \
    libxslt1-dev \
    libboost1.55-all-dev \
    libxmltooling-dev \
    liblog4shib-dev \
    libsaml2-dev \
    libboost1.55-dev \
    libfcgi-dev \
    po-debconf \
    debhelper \
    xmltooling-schemas \
    opensaml2-schemas \
    build-essential

VOLUME ['/opt/shib_sp']

RUN cd /opt/shibboleth-sp-2.5.4/configure && \
    ./configure --with-fastcgi --prefix=/opt/shib_sp && \
    make && \
    make install
