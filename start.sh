#!/bin/bash

echo "Starting PHP-FPM..."

/usr/sbin/php-fpm8.1 --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize


echo "Starting Nginx..."

/usr/sbin/apache2 -f /home/container/apache2/apache2.conf

echo "Starting Website..."

service php8.1-fpm status
php -v
apache2 -v
/bin/bash -c "trap : TERM INT; sleep infinity & wait"
