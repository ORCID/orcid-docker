FROM orcid:puppet

MAINTAINER Jeff P. <jeff@siccr.com>

ENV LANG en_US.utf8

COPY puppet_modules/orcid/manifests/*.pp /opt/

RUN puppet apply --environment qa --modulepath /opt/orcid-puppet/modules:/etc/puppet/modules /opt/orcid_postgresql.pp

USER postgres

VOLUME ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

EXPOSE 5432

CMD ["/usr/lib/postgresql/9.5/bin/postgres", "-D", "/var/lib/postgresql/9.5/main", "-c", "config_file=/etc/postgresql/9.5/main/postgresql.conf"]
