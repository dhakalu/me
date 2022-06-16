resource "aws_vpc" "me-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "me-vpc"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id            = aws_vpc.me-vpc.id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name        = "me-public-subnet-1"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id            = aws_vpc.me-vpc.id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name        = "me-public-subnet-2"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.me-vpc.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name        = "me-private-subnet-1"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.me-vpc.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name        = "me-private-subnet-2"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "private-subnet-3" {
  vpc_id            = aws_vpc.me-vpc.id
  cidr_block        = var.private_subnet_3_cidr
  availability_zone = "us-east-1c"
  tags = {
    Name        = "me-private-subnet-3"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "database-subnet-1" {
  vpc_id            = aws_vpc.me-vpc.id
  cidr_block        = var.database_subnet_1_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name        = "me-database-subnet-1"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "database-subnet-2" {
  vpc_id            = aws_vpc.me-vpc.id
  cidr_block        = var.database_subnet_2_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name        = "me-database-subnet-2"
    COST_CENTER = "personal-website"
  }
}

resource "aws_internet_gateway" "me-internet-gateway" {
  vpc_id = aws_vpc.me-vpc.id

  tags = {
    Name        = "me-internet-gateway"
    COST_CENTER = "personal-website"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.me-vpc.id

  route {
    cidr_block = "0.0.0.0/32"
    gateway_id = aws_internet_gateway.me-internet-gateway.id
  }

  tags = {
    Name        = "me-public-route-table"
    COST_CENTER = "personal-website"
  }
}

resource "aws_route_table_association" "public-rta-subnet-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-rta-subnet-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}
