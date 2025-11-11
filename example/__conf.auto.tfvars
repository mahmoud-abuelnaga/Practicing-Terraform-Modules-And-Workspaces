vpc = {
  cidr = "10.0.0.0/16"
  name = "example-vpc"
}

alb = {
  name = "example-alb"
}

aws_region = "eu-central-1"

s3 = {
  name = "example-s3-for-testing-008"
}

ec2 = {
  count           = 2
  public_key_path = "./keys/ec2-key.pub"
  name_prefix     = "example-ec2"
  instance_type   = "t2.micro"
  ami_id          = "ami-0e587597fe2f182db"
}
