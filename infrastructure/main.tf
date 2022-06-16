terraform {
  required_version = ">=1.2.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.18.0"
    }
  }
}

module "network" {
  source                 = "./network"
  vpc_cidr               = ""
  private_subnet_1_cidr  = ""
  private_subnet_2_cidr  = ""
  private_subnet_3_cidr  = ""
  public_subnet_1_cidr   = ""
  public_subnet_2_cidr   = ""
  database_subnet_1_cidr = ""
  database_subnet_2_cidr = ""
}
