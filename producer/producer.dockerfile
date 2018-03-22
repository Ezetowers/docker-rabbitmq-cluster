FROM alpine:3.5

WORKDIR /tmp

RUN apk --update add supervisor bash python3 vim && \
    pip3 install --upgrade pip && \
    pip3 install pika

# Download, install and configure zookeeper
# ADD config/zookeeper /tmp/zookeeper/
# RUN wget http://apache.dattatec.com/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz && \
#     mkdir /opt && tar xzvf zookeeper-3.4.10.tar.gz -C /opt/ && \
#     cp zookeeper/zoo.cfg /opt/zookeeper-3.4.10/conf && \
#     rm -rf zookeeper-3.4.10.tar.gz

# Configure supervisor to start zookeeper
ADD config/supervisor /tmp/supervisor
RUN mkdir -p /etc/supervisor/conf.d && \
    cp supervisor/supervisord.conf /etc/supervisor/supervisord.conf && \
    cp supervisor/producer.conf /etc/supervisor/conf.d/

ADD config/producer/producer.py /root/
ADD config/init.sh /root/

CMD /root/init.sh
