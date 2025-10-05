variable "waf_log_group_name" {
  type        = string
  description = "The name of the CloudWatch Log Group for WAF logs"
}

variable "waf_log_group_retention_in_days" {
  type        = number
  description = "The retention period in days for the WAF CloudWatch Log Group"
  default     = 30
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the WAF CloudWatch Log Group"
  default     = {}
}