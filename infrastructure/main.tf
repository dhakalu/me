terraform {
  required_version = ">=1.2.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.18.0"
    }
  }

  cloud {
    organization = "apna-website"

    workspaces {
      name = "gh-actions-me"
    }
  }
}

locals {
  region = "us-east-1"
}

provider "aws" {
  region = local.region
}

locals {
  vpc_cidr = "10.10.0.0/16"
  public_cidrs = {
    us-east-1a : "10.10.4.0/24",
    us-east-1b : "10.10.5.0/24"
  }
  private_cidrs = {
    us-east-1a : "10.10.1.0/24",
    us-east-1b : "10.10.2.0/24",
    us-east-1c : "10.10.3.0/24"
  }
  database_cidrs = {
    us-east-1a : "10.10.6.0/24",
    us-east-1b : "10.10.7.0/24"
  }
}

module "network" {
  source                = "./network"
  vpc_cidr              = local.vpc_cidr
  public_subnets_cidr   = local.public_cidrs
  database_subnets_cidr = local.database_cidrs
  private_subnets_cidr  = local.private_cidrs
}

module "frontend" {
  source = "./front-end"
}

module "backend" {
  source          = "./back-end"
  vpc_id          = module.network.me_vpc_id
  public_subnets  = module.network.public_subnets
  private_subnets = module.network.private_subnets
}

module "terraform_role" {
  source = "./roles"
}
