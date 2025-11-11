terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


locals {
  aws_region = var.aws_region
  global_tags = merge(var.global_tags,
    {
      environment = var.environment
    }
  )
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.global_tags
  }
}
