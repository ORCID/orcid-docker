
## Simple Apache + Drupal app

Using base image from https://hub.docker.com/_/drupal/

    docker run --name orcid-about --link db-about.orcid.org:mysql -p 8080:80 -d drupal:7-apache

Then, access it via http://localhost:8080 or http://host-ip:8080 in a browser.






