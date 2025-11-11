variable "ec2" {
  type = object({
    count           = number
    ami_id          = string
    instance_type   = string
    name_prefix     = string
    public_key_path = string
  })

}
