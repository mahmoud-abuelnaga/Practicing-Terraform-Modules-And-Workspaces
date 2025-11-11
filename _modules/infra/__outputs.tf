# vpc outputs
output "public_subnets_ids" {
  value = module.vpc.public_subnets
}

output "public_subnets_cidrs" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "private_subnets_ids" {
  value = module.vpc.private_subnets
}

output "private_subnets_cidrs" {
  value = module.vpc.private_subnets_cidr_blocks
}

# alb outputs
output "alb_dns_name" {
  value = module.alb.dns_name
}

output "alb_arn" {
  value = module.alb.arn
}
