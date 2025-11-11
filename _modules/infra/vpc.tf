data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  subnet_increment = 4
  az_count         = length(data.aws_availability_zones.available.names)
  subnet_count     = local.az_count * 2 # 2 subnets per AZ (public and private)
  subnets_cidr     = cidrsubnets(var.vpc.cidr, [for i in range(local.subnet_count) : local.subnet_increment]...)
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc.name
  cidr = var.vpc.cidr

  azs             = data.aws_availability_zones.available.names
  public_subnets  = slice(local.subnets_cidr, 0, local.az_count)
  private_subnets = slice(local.subnets_cidr, local.az_count, local.az_count * 2)

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Type = "public"
    vpc  = var.vpc.name
  }

  private_subnet_tags = {
    Type = "private"
    vpc  = var.vpc.name
  }
}
