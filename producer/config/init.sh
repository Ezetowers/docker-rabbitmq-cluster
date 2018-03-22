#!/bin/bash

# Cannot live without this alias, sorry!!
echo 'alias ll="ls -l"' > /root/.bashrc

# Start supervisor (it will start zookeeper)
mkdir -p /var/log/supervisor
supervisord -c /etc/supervisor/supervisord.conf

touch /root/producer.log
tail -f /root/producer.log