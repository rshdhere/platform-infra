# Messaging

The proposed CMS architecture uses [Amazon SQS](sqs/) to carry work from checkout to fulfillment. Two queues let order processing and store picking scale independently.

| Queue | How it is used |
| --- | --- |
| Order events | The checkout API commits the order and its outbox event together in Aurora. An EKS relay publishes the committed event through the SQS interface endpoint. A Lambda event source mapping polls the queue and invokes the fulfillment consumer. |
| Store picking | EKS worker pods process picking jobs. KEDA monitors the queue backlog and adjusts the worker replica count. |

An order event can arrive more than once. The fulfillment consumer should deduplicate by event ID so a retry creates only one picking task for the assigned store. The order queue’s redrive policy sends repeatedly failing messages to a dead-letter queue for investigation. CloudWatch alarms should flag aging order events and messages arriving in the dead-letter queue.

[VPC architecture diagram](https://github.com/rshdhere/quick-commerce/blob/main/docs/vpc/vpc.png)
