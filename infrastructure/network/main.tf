terraform {
  required_version = ">=1.2.3"
  provider "aws" {
    region = "us-east-1"
  }
}


resource "aws_vpc" "me-vpc" {
  cidr_block = var.vpc_cidr
  tags {
    Name        = "me-vpc"
    COST_CENTER = "personal-website"
  }
}

output "vpc-id" {
  value = aws_vpc.me-vpc.id
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id            = aws_vpc.me-vpc.id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = "us-east-1a"
  tags {
    Name        = "me-public-subnet-1"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id            = aws_vpc.me-vpc.id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = "us-east-1b"
  tags {
    Name        = "me-public-subnet-2"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.me-vpc.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = "us-east-1a"
  tags {
    Name        = "me-private-subnet-1"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.me-vpc.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = "us-east-1b"
  tags {
    Name        = "me-private-subnet-1"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "private-subnet-3" {
  vpc_id            = aws_vpc.me-vpc.id
  cidr_block        = var.private_subnet_3_cidr
  availability_zone = "us-east-1c"
  tags {
    Name        = "me-private-subnet-1"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "database-subnet-1" {
  vpc_id            = aws_vpc.me-vpc.id
  cidr_block        = var.database_subnet_1_cidr
  availability_zone = "us-east-1a"
  tags {
    Name        = "me-database-subnet-1"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "database-subnet-2" {
  vpc_id            = aws_vpc.me-vpc.id
  cidr_block        = var.database_subnet_2_cidr
  availability_zone = "us-east-1b"
  tags {
    Name        = "me-database-subnet-2"
    COST_CENTER = "personal-website"
  }
}


