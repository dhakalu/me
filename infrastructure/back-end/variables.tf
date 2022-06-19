variable "public_subnets" {
  type        = set(string)
  description = "List of public subnet ids"
}

variable "private_subnets" {
  type        = set(string)
  description = "List of private subnet ids"
}

variable "vpc_id" {
  type        = string
  description = "List of private subnet ids"
}
