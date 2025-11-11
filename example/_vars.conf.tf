variable "ec2" {
  type = object({
    name_prefix     = string
    instance_type   = string
    ami_id          = string
    count           = number
    public_key_path = string
  })
}

variable "s3" {
  type = object({
    name = string
  })
}

variable "alb" {
  type = object({
    name = string
  })
}

variable "vpc" {
  type = object({
    name = string
    cidr = string
  })
}

variable "environment" {
  type        = string
  description = "The deployment environment (e.g., dev, prod, staging)."

  validation {
    condition     = contains(["dev", "prod", "staging"], var.environment)
    error_message = "Invalid environment specified. Use 'dev', 'prod', or 'staging'."
  }
}
