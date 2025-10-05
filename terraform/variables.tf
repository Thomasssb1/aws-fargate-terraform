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