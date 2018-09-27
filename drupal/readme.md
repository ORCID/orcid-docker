
## Simple Apache + Drupal app

Build similar solution as

    root@about-qa-4:/etc/apt/sources.list.d# mysql -V
        mysql  Ver 15.1 Distrib 5.5.59-MariaDB, for debian-linux-gnu (x86_64) using readline 5.2
    root@about-qa-4:/etc/apt/sources.list.d# apache2 -v
        Server version: Apache/2.4.7 (Ubuntu)
        Server built:   Apr 18 2018 15:36:26
    root@about-qa-4:/etc/apt/sources.list.d# php -v
        PHP 5.5.9-1ubuntu4.25 (cli) (built: May 10 2018 14:37:18) 
        Copyright (c) 1997-2014 The PHP Group
        Zend Engine v2.5.0, Copyright (c) 1998-2014 Zend Technologies
            with Zend OPcache v7.0.3, Copyright (c) 1999-2014, by Zend Technologies
    root@about-qa-4:/etc/apt/sources.list.d#

### Migrate from QA drupal server

    jperez@about-qa-4:~$ cd /var/www/about_drupal/docroot && drush archive-dump --overwrite --destination='/home/jperez/about_drupal.tgz'
        Database dump saved to /tmp/drush_tmp_1534543575_5b7746d799c32/drupal7_about.sql                                                                                                    [success]
        Archive saved to /data_disk/home/jperez/about_drupal.tgz                                                                                                                            [ok]
        /data_disk/home/jperez/about_drupal.tgz
    jperez@about-qa-4:~$ exit
    jperez@asusxubuntu:~/Downloads$ scp about-qa-4-loc.orcid.org:~/about_drupal.tgz .

    tar xzf about_drupal.tgz
    mv 

Prepare database service and content, using base image from https://hub.docker.com/_/mysql/

    docker volume create orcid_about
    docker run --rm --name about-db \
    -e MYSQL_ROOT_PASSWORD=ab0u7 \
    -e MYSQL_DATABASE=about \
    -v orcid_about:/var/lib/mysql \
    -v ./initdb:/docker-entrypoint-initdb.d
    -d mysql:5.5

Using base image from https://hub.docker.com/_/drupal/

    docker run --name orcid-about --link about-db:about-db.orcid.org -p 8888:80 -d drupal:7-apache

Then, access it via http://localhost:8888
















## References

* https://drupalize.me/tutorial/dockerize-existing-project?p=3040







