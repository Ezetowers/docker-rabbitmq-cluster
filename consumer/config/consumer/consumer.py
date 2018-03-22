import pika
import time
import logging

logpath = "/root/consumer.log"
logger = logging.getLogger('log')
logger.setLevel(logging.INFO)
ch = logging.FileHandler(logpath)
ch.setFormatter(logging.Formatter('%(message)s'))
logger.addHandler(ch)

logger.info("Consumer: Proceed to receive message from Rabbit")
connection = pika.BlockingConnection(pika.ConnectionParameters(host='haproxy'))
channel = connection.channel()

channel.queue_declare(queue='task_queue', durable=True)
logger.info(' [*] Waiting for messages. To exit press CTRL+C')


def callback(ch, method, properties, body):
    logger.info(" [x] Received %r" % body)
    time.sleep(body.count(b'.'))
    print(" [x] Done")
    ch.basic_ack(delivery_tag=method.delivery_tag)

channel.basic_qos(prefetch_count=1)
channel.basic_consume(callback,
                      queue='task_queue')

channel.start_consuming()
