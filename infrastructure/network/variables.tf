

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "public_subnets_cidr" {
  type        = map(any)
  description = "CIDR blocks for public subnets"
}

variable "private_subnets_cidr" {
  type        = map(any)
  description = "CIDR block for private subnet 1"
}


variable "database_subnets_cidr" {
  type        = map(string)
  description = "CIDR block for private subnet 1"
}

