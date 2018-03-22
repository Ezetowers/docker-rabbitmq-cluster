#!/bin/bash

# Cannot live without this alias, sorry!!
echo 'alias ll="ls -l"' > /root/.bashrc
echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk' >> /root/.bashrc

# Start supervisor (it will start zookeeper)
mkdir -p /var/log/supervisor
supervisord -c /etc/supervisor/supervisord.conf

touch /root/consumer.log
tail -f /root/consumer.log