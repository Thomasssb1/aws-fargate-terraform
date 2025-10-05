variable "name" {
  description = "The name of the ECR repository"
  type        = string
  default     = "main-discord-bot"
}

variable "mutable" {
  description = "Whether the image tags are mutable or immutable"
  type        = bool
  default     = true
}