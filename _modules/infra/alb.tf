module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 10.0"

  name               = var.alb.name
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  enable_deletion_protection = false

  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"

      forward = {
        target_group_key = "ec2-instances"
      }
    }
  }

  target_groups = {
    ec2-instances = {
      protocol    = "HTTP"
      port        = 8080
      target_type = "instance"
      create_attachment = false
    }
  }

  additional_target_group_attachments = {
    for idx, instance in aws_instance.instance :
    "instance-${idx}" => {
      target_group_key = "ec2-instances"
      target_type      = "instance"
      target_id        = instance.id
      port             = 8080
    }
  }
}
