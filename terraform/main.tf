module "vpc" {
  source            = "./modules/vpc"
  availability_zone = var.region // Automatically adds a & b for public and private
}

module "cloudwatch" {
  source                          = "./modules/cloudwatch"
  waf_log_group_name              = "waf-log-group-${var.region}"
  waf_log_group_retention_in_days = 30
  tags                            = {}
}