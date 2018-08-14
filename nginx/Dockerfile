FROM ubuntu:14.04

LABEL maintainer="Jeff P. <jeff@siccr.com>"

ENV LANG en_US.utf8

RUN apt-get update && \
    apt-get install -y libgd3  \
    liblua5.1-0 \
    libperl5.18 \
    libxslt1.1 \
    libgeoip1 \
    opensaml2-tools \
    opensaml2-schemas \
    xmltooling-schemas \
    dh-systemd \
    supervisor

ADD https://github.com/ORCID/registry_vagrant/raw/master/puppet/modules/shibboleth_nginx/files/src/nginx-common_1.4.6-1ubuntu4_all.deb /opt/

RUN dpkg -i /opt/nginx-common_1.4.6-1ubuntu4_all.deb

ADD https://github.com/ORCID/registry_vagrant/raw/master/puppet/modules/shibboleth_nginx/files/src/nginx-extras_1.4.6-1ubuntu4_amd64.deb /opt/

RUN dpkg --force-all -i /opt/nginx-extras_1.4.6-1ubuntu4_amd64.deb

COPY orcid/configure_and_serve.sh /usr/bin/orcid_up.sh

COPY nginx/supervisor_shib.conf /etc/supervisor/conf.d/shibboleth.conf

RUN chmod +x /usr/bin/orcid_up.sh

ENTRYPOINT ["/usr/bin/orcid_up.sh"]
