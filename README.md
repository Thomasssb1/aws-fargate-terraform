# AWS Fargate Terraform

AWS architecture:

- VPC with 2 subnets (public & private):
  - VPC endpoint for DDB allowing ECS and Lambda to access it on the private subnet
  - VPC endpoint for ECR to pull the image without needing the NAT gateway
- Security group:
  - ALB should allow all inbound traffic for TLS
  - ECS Fargate should allow only inbound traffic from the ALB security group
  - Lambda should only have outbound access to DDB
- IAM roles:
  - Permission to write to DDB in ECS
  - Permission to read from DDB in Lambda
- WAF, ALB & NAT gateway:
  - WAF used to inspect incoming data from the public route table
  - ALB used to distribute the connection and limit inbound traffic
  - NAT gateway allows private subnet instances access to the internet through the public subnet and IGW
- ECS fargate:
  - Should run in a private subnet (ALB is in the public subnet and forwards traffic to the private subnet)
- ECR:
  - Can be connected to via a VPC endpoint
  - Lifecycle policy which removed untagged images older than 7 days
- EventBridge, Lambda & SQS:
  - EventBridge used to send a request to the Lambda every x minutes
  - SQS used to send data to the ECS instance from the Lambda
