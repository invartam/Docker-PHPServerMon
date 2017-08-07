# Introduction
## Presentation
PHPServerMon is a simple opensource server monitoring software.
It helps you to monitor your services and your websites, simply declare your
services and websites in the application and PHPServerMon will check them and
warn you by mail, sms and/or push notifications when their status changes.

## What's inside this container
This container contains the phpservermon application bundled with a script that
will trigger the check of the services at a user defined interval.

## Running the image
To run this image you need to have a mysql server up and configured.
You need to create the database for phpservermon before starting the app.

    docker run -d -p 80:80 -e PSM_BASE_URL="" \
                           -e PSM_DB_HOST="mysql" \
                           -e PSM_DB_PORT="3306" \
                           -e PSM_DB_NAME="phpservermon" \
                           -e PSM_DB_USER="root" \
                           -e PSM_DB_PASS="test" \
                           -e PSM_DB_PREFIX="" \
                           -e UPDATE_INTERVAL=30
               --name phpservermon invartam/docker-phpservermon

## Application configuration
The configuration is done via environment variables passed to the container.
The environment variables are:
* PSM_BASE_URL: if you run phpservermon behind a reverse proxy, set this
variable with the full URL to access it with http:// or https://
(ie. https://monitor.domain.tld).
* PSM_DB_HOST: hostname of the mysql server.
* PSM_DB_NAME: name of the database created for the application.
* PSM_DB_USER: username to connect to the database.
* PSM_DB_PASS: password for the provided username.
* PSM_DB_PREFIX: prefix put at the beginning of the tables name.
* UPDATE_INTERVAL: interval in second between each services status check
(default: 30s).

# Sample docker-compose configuration

    version: "2"
    services:
      mysql:
        image: mysql
        container_name: mysql
        environment:
         - MYSQL_ROOT_PASSWORD=test
        expose:
          - "3306"

      phpmyadmin:
        image: phpmyadmin/phpmyadmin
        environment:
         - PMA_HOST=mysql
         - PMA_USER=root
         - PMA_PASSWORD=test
       container_name: phpmyadmin
       ports:
         - "8080:80"

      phpservermon:
        image: invartam/docker-phpservermon
        container_name: phpservermon
        environment:
          - PSM_BASE_URL=""
          - PSM_DB_HOST="mysql"
          - PSM_DB_PORT="3306"
          - PSM_DB_NAME="phpservermon"
          - PSM_DB_USER="root"
          - PSM_DB_PASS="test"
          - PSM_DB_PREFIX=""
          - UPDATE_INTERVAL=30
        ports:
          - "8081:80"

# Sources
* Image Github: https://github.com/invartam/Docker-PHPServerMon
* PHPServerMon Github: https://github.com/phpservermon/phpservermon
* PHPServerMon website: http://www.phpservermonitor.org/
