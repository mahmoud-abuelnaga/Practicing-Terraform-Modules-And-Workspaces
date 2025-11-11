module "infra" {
  source = "../_modules/infra"

  ec2 = var.ec2
  s3  = var.s3
  alb = var.alb
  vpc = var.vpc
}
