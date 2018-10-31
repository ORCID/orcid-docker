FROM drupal:7-apache

WORKDIR /var/www/html

RUN cd /var/www/about_drupal/docroot && drush archive-dump --overwrite --destination='/home/jperez/about_drupal.tgz

