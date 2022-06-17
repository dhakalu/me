terraform {
  required_version = ">=1.2.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.18.0"
    }
  }
}

locals {
  region = "us-east-1"
}

provider "aws" {
  region = local.region
}

module "network" {
  source                 = "./network"
  vpc_cidr               = "10.10.0.0/16"
  private_subnet_1_cidr  = "10.10.1.0/24"
  private_subnet_2_cidr  = "10.10.2.0/24"
  private_subnet_3_cidr  = "10.10.3.0/24"
  public_subnet_1_cidr   = "10.10.4.0/24"
  public_subnet_2_cidr   = "10.10.5.0/24"
  database_subnet_1_cidr = "10.10.6.0/24"
  database_subnet_2_cidr = "10.10.7.0/24"
}
