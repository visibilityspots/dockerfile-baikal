#!/bin/sh
set -e

# config/ and Specific/ are volumes; a fresh one starts out owned by root.
# Only the directories themselves are fixed, never recursively: on an NFS
# volume a chown -R on every start is slow and rewrites what is already right.
mkdir -p /var/www/baikal/Specific/db
chown baikal:nginx /var/www/baikal/config /var/www/baikal/Specific /var/www/baikal/Specific/db

php-fpm84 --daemonize
exec nginx -g 'daemon off;'
