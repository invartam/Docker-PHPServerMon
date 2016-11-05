#!/bin/sh

while [ true ]; do
	/usr/local/bin/php /var/www/html/cron/status.cron.php
	sleep 15
done
