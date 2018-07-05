#!/bin/sh

sed -i s|REGISTRY_IP_PORT|${REGISTRY_IP_PORT}|g /etc/nginx/sites-enabled/default
nginx -g 'daemon off;'

