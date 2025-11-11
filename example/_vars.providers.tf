variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "global_tags" {
  type    = map(string)
  default = {}
}
