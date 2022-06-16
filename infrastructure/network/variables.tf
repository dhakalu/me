

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "public_subnet_1_cidr" {
  type        = string
  description = "CIDR block for public subnet 1"
}

variable "public_subnet_2_cidr" {
  type        = string
  description = "CIDR block for public subnet 2"
}

variable "private_subnet_1_cidr" {
  type        = string
  description = "CIDR block for private subnet 1"
}

variable "private_subnet_2_cidr" {
  type        = string
  description = "CIDR block for private subnet 2"
}

variable "private_subnet_3_cidr" {
  type        = string
  description = "CIDR block for private subnet 3"
}

variable "database_subnet_1_cidr" {
  type        = string
  description = "CIDR block for private subnet 1"
}

variable "database_subnet_2_cidr" {
  type        = string
  description = "CIDR block for private subnet 2"
}
