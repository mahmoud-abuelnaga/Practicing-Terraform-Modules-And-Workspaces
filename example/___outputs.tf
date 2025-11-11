# vpc outputs
output "public_subnets_ids" {
  value = module.infra.public_subnets_ids
}

output "public_subnets_cidrs" {
  value = module.infra.public_subnets_cidrs
}

output "private_subnets_ids" {
  value = module.infra.private_subnets_ids
}

output "private_subnets_cidrs" {
  value = module.infra.private_subnets_cidrs
}

# alb outputs
output "alb_dns_name" {
  value = module.infra.alb_dns_name
}

output "alb_arn" {
  value = module.infra.alb_arn
}

