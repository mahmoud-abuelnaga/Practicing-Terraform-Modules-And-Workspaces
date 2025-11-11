locals {
  environment = var.environment

  ec2 = merge(
    var.ec2,
    {
      name_prefix = "${var.ec2.name_prefix}-${local.environment}"
    }
  )

  s3 = merge(
    var.s3,
    {
      name = "${var.s3.name}-${local.environment}"
    }
  )

  alb = merge(
    var.alb,
    {
      name = "${var.alb.name}-${local.environment}"
    }
  )

  vpc = merge(
    var.vpc,
    {
      name = "${var.vpc.name}-${local.environment}"
    }
  )
}


module "infra" {
  source = "../_modules/infra"

  ec2 = local.ec2
  s3  = local.s3
  alb = local.alb
  vpc = local.vpc
}
