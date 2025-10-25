variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-2"
}

variable "container_name" {
  description = "The name of the container to deploy"
  type        = string
  default     = "main-container"
}

variable "container_image" {
  description = "Docker image to deploy"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "task_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 2
}


variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 5000
}

variable "cpu" {
  description = "CPU units for the ECS task"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memory (in MiB) for the ECS task"
  type        = number
  default     = 512
}