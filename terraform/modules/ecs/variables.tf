variable "container_name" {
  type    = string
  default = "csfloat-notifier"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "cpu" {
  description = "The number of CPU units used by the task."
  type        = number
}

variable "memory" {
  description = "The amount of memory (in MiB) used by the task."
  type        = number
}

variable "execution_role_arn" {
  description = "The ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume."
  type        = string
}

variable "container_image" {
  description = "The Docker image for the application container."
  type        = string
}

variable "container_port" {
  description = "The port on which the application container listens."
  type        = number
}

variable "region" {
  description = "The AWS region where resources will be created."
  type        = string
}

variable "task_count" {
  description = "The desired number of instantiations of the task definition to run on the service."
  type        = number
  default     = 1
}

variable "target_group_arn" {
  description = "The ARN of the load balancer target group to associate with the service."
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the service."
  type        = list(string)
}

variable "subnet_ids" {
  description = "A list of subnet IDs to associate with the service."
  type        = list(string)
}
