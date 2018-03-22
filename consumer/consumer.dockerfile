FROM alpine:3.5

WORKDIR /tmp

RUN apk --update add supervisor bash python3 vim openjdk8-jre openjdk8 maven && \
    pip3 install --upgrade pip && \
    pip3 install pika 

# Configure supervisor to start zookeeper
ADD config/supervisor /tmp/supervisor
RUN mkdir -p /etc/supervisor/conf.d && \
    cp supervisor/supervisord.conf /etc/supervisor/supervisord.conf && \
    cp supervisor/consumer.conf /etc/supervisor/conf.d/

ADD config/consumer/consumer.py /root/
ADD config/init.sh /root/
CMD /root/init.sh
