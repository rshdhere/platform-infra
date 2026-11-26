# Storage

The proposed CMS architecture uses [Amazon S3](s3/) for container image downloads and Kubernetes backups. EKS workloads reach S3 through the gateway endpoint associated with the private subnet route tables.

| Workflow | How it uses S3 |
| --- | --- |
| EKS image pull | The worker node requests an image from ECR. ECR returns a pre-signed URL for a layer in its regional S3 bucket. The node downloads the layer through the S3 gateway endpoint. |
| Kubernetes recovery | Velero writes Kubernetes resource backups to a CMS-owned S3 bucket and reads them during a restore. Aurora uses its own database backups for order and inventory recovery. |

[VPC architecture diagram](https://github.com/rshdhere/quick-commerce/blob/main/docs/vpc/vpc.png)
