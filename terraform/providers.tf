terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.14.0"
    }
  }

  backend "s3" {
    bucket  = "csfloat-notifier-terraform-state"
    key     = "terraform.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}

provider "aws" {
  shared_config_files = ["~/.aws/credentials"]
  profile             = "default"
  region              = "eu-west-2"
}