variable "waf_name" {
  type        = string
  description = "The name of the WAF Web ACL"
}

variable "waf_log_group_arn" {
  type        = string
  description = "The ARN of the CloudWatch Log Group for WAF logs"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the WAF Web ACL"
  default     = {}
}