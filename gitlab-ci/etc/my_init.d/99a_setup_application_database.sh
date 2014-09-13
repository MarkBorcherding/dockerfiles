#!/usr/bin/env sh

echo 'Starting mysqld'
# The sleep 1 is there to make sure that inotifywait starts up before the socket is created
mysqld_safe &

echo 'Waiting for mysqld to come online'
while [ ! -x /var/run/mysqld/mysqld.sock ]; do
    sleep 1
done

# Setup tables
sudo --user gitlab_ci --preserve-env --set-home bundle exec rake setup

# Setup schedules
sudo --user gitlab_ci --preserve-env --set-home bundle exec whenever --write-crontab

echo 'Shutting down mysqld'
mysqladmin -uroot -proot shutdown
