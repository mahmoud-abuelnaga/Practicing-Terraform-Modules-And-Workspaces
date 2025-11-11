resource "aws_security_group" "ec2" {
  name        = "${var.ec2.name_prefix}-sg"
  description = "Security group for EC2 instances"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Allow HTTP traffic on port 8080"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [module.alb.security_group_id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "ec2" {
  key_name   = "${var.ec2.name_prefix}-key"
  public_key = file(var.ec2.public_key_path)
}


# ---------------------------------- #


resource "aws_instance" "instance" {
  count         = var.ec2.count
  ami           = var.ec2.ami_id
  instance_type = var.ec2.instance_type
  key_name      = aws_key_pair.ec2.key_name

  subnet_id              = element(module.vpc.public_subnets, count.index % length(module.vpc.public_subnets))
  vpc_security_group_ids = [aws_security_group.ec2.id]

  user_data = <<-EOF
              #!/bin/bash
              mkdir -p /var/www/html
              echo "<h1>Welcome to Terraform EC2 Instance</h1>" > /var/www/html/index.html
              cd /var/www/html
              nohup python3 -m http.server 8080 &
              EOF

  tags = {
    Name = "${var.ec2.name_prefix} - ${count.index}"
  }
}
