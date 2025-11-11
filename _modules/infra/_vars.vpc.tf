variable "vpc" {
  type = object({
    name = string
    cidr = string
  })

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}\\/16$", var.vpc.cidr))
    error_message = "Invalid cidr. You need to provide a valid /16 CIDR block."
  }
}
