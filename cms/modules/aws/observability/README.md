# Observability

In the proposed CMS architecture, [CloudWatch](cloudwatch/) helps operators spot delays between payment and store fulfillment. The EKS workload log agent sends logs over HTTPS through the CloudWatch Logs interface endpoint in the VPC.

| Signal | What to investigate |
| --- | --- |
| Oldest order event in SQS | A rising age can indicate that fulfillment consumers are falling behind. |
| Messages in the order dead-letter queue | Inspect consumer errors for the failed event before redriving it. |
| Paid order awaiting a picking task | Track elapsed time from payment confirmation to task creation as an application metric. This catches delays even when the queue is empty. |

For an individual checkout, use Grafana to query Prometheus metrics, Loki logs, and OpenTelemetry traces stored in Tempo. Carry the trace ID across the API, outbox relay, and fulfillment consumer so an operator can follow the same order across those steps. Keep delivery addresses, phone numbers, and payment payloads out of telemetry.

[VPC architecture diagram](https://github.com/rshdhere/quick-commerce/blob/main/docs/vpc/vpc.png)
