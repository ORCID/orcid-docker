# Deploy ORCID with DOCKER

This project uses docker containers to startup JavaEE PostgreSQL [web application](https://qa.orcid.org/). The local environment will be available at [localhost](https://localhost:8443/)

## Install docker community edition

Follow install instructions at https://docs.docker.com/install/

* [Get Docker for Mac](https://download.docker.com/mac/stable/Docker.dmg)
* [Get Docker for Windows](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)
* [Get Docker for Linux](https://download.docker.com/linux/static/stable/aarch64/docker-18.03.1-ce.tgz)

## Install docker compose 
Follow instructions for [installing docker-compose on macOS, Windows, and 64-bit Linux ](https://docs.docker.com/compose/install/)

> Validate tool is available by running `docker-compose ps`, a list of docker containers is shown.

## Startup orcid-web with docker compose

### Download this container wrapper

    git clone https://github.com/ORCID/orcid-docker.git
    cd orcid-docker

### Prepare orcid-web java web application

Build and pack the orcid web war file, helper script and config at

    cp ./tomcat/test.env .env
    sh ./tomcat/build.sh

|   Env Var     |       Description              |
|---------------|--------------------------------|
| ORCID_SOURCE  | /Users/jperez/git/ORCID_Source |
| PG_PASSWORD   | orcid                          |

> Rename test.env as .env update as needed

### Run

To start all services from the root folder do

    docker-compose up -d

> We can found containers IP from container name with `docker inspect --format '{{ (index .NetworkSettings.Networks "orcid_default").IPAddress }}' orcid_web_1`

and.. That's it.

### Test web app

Test the service with

    curl -I -k -L https://localhost:8443/orcid-web/signin

or simply browse to https://localhost:8443/orcid-web

### Shutdown your local environment

Later we can stop or destroy the environment with

    docker-compose stop
    docker-compose down
    docker-compose ps

* Read More tomcat/README.md
