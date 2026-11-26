# Amazon SQS

The CMS design uses an order queue to hand off fulfillment after checkout. The checkout API writes the order and its outbox event in one Aurora transaction. After commit, an EKS relay publishes the event through the SQS interface endpoint. A Lambda event source mapping polls the queue and invokes the fulfillment consumer.

SQS can deliver an event more than once. The consumer should use the event ID to ensure that retries create only one picking task for the assigned store. After repeated failures, the queue's redrive policy moves the message to a dead-letter queue. Monitor the age of the oldest order event and alert when messages reach the dead-letter queue.

KEDA monitors a separate picking queue to scale worker pods independently of the Lambda order consumer.

[VPC architecture diagram](https://github.com/rshdhere/quick-commerce/blob/main/docs/vpc/vpc.png)
