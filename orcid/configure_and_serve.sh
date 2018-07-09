#!/bin/sh

cp /orcid/site_available_default /etc/nginx/sites-available/default
cp /orcid/etc_nginx/* /etc/nginx/
sed -i "s|REGISTRY_IP_PORT|${REGISTRY_IP_PORT}|g" /etc/nginx/sites-enabled/default
nginx -g 'daemon off;'

