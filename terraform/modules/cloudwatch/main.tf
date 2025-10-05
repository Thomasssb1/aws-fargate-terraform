resource "aws_cloudwatch_log_group" "waf_log_group" {
  name              = var.waf_log_group_name
  retention_in_days = var.waf_log_group_retention_in_days
}
