resource "aws_wafv2_web_acl" "main" {
  name        = var.waf_name
  description = "WAF web ACL for ALB" // Access Control List for Application Load Balancer
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "common-rules"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.waf_name}-blocked-common-rules"
      sampled_requests_enabled   = false // Does not store full requests in CloudWatch Logs
    }
  }

  tags = var.tags

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "${var.waf_name}-allowed"
    sampled_requests_enabled   = false
  }
}

resource "aws_wafv2_web_acl_logging_configuration" "main" {
  log_destination_configs = [var.waf_log_group_arn]
  resource_arn            = aws_wafv2_web_acl.main.arn
  redacted_fields {
    // TODO: add authentication headers here if necessary
    single_header {
      name = "user-agent"
    }
  }
}