output "waf_log_group_arn" {
  description = "The ARN of the WAF CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.waf_log_group.arn
}