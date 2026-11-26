# Amazon Aurora PostgreSQL

In the proposed CMS architecture, Aurora holds store prices, inventory reservations, orders, and the outbox of events awaiting publication. Stock is tracked by store and SKU so an order reserves units at the store that will fulfill it.

## Checkout transaction

The API rechecks the price on the writer and reserves stock only if enough units remain. It commits the reservation, order, and outbox entry in one transaction. If two shoppers request the last unit, only one reservation can succeed. A unique checkout key lets the API return the existing order when a client retries.

After commit, an EKS relay publishes the outbox event to SQS. Consumers deduplicate by event ID because the relay can publish an event again after a retry. See the [messaging overview](../messaging/README.md).

## Connectivity and recovery

The design places a writer and a failover reader in isolated database subnets across two Availability Zones. Authorized EKS workloads reach the writer through the cluster endpoint on TCP 5432. Aurora database backups cover order and inventory recovery. Velero handles Kubernetes resources.

[VPC architecture diagram](https://github.com/rshdhere/quick-commerce/blob/main/docs/vpc/vpc.png)
