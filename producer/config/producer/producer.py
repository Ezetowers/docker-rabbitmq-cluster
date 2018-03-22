import logging
import pika
import random
import sys

from time import sleep

logpath = "/root/producer.log"
logger = logging.getLogger('log')
logger.setLevel(logging.INFO)
ch = logging.FileHandler(logpath)
ch.setFormatter(logging.Formatter('%(message)s'))
logger.addHandler(ch)

connection = pika.BlockingConnection(pika.ConnectionParameters(host='haproxy'))
channel = connection.channel()

channel.queue_declare(queue='task_queue', durable=True)

while True:
    message = "Deep Message " + "." * random.randint(1, 5)
    channel.basic_publish(exchange='',
                          routing_key='task_queue',
                          body=message,
                          properties=pika.BasicProperties(
                              delivery_mode=2,  # make message persistent
                          ))
    logger.info(" [x] Sent %r" % message)
    sleep(10)
connection.close()
