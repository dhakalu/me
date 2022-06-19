resource "aws_vpc" "me" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "me-vpc"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.me.id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name        = "me-public-subnet-1"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.me.id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name        = "me-public-subnet-2"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.me.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name        = "me-private-subnet-1"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.me.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name        = "me-private-subnet-2"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "private_3" {
  vpc_id            = aws_vpc.me.id
  cidr_block        = var.private_subnet_3_cidr
  availability_zone = "us-east-1c"
  tags = {
    Name        = "me-private-subnet-3"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "database_1" {
  vpc_id            = aws_vpc.me.id
  cidr_block        = var.database_subnet_1_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name        = "me-database-subnet-1"
    COST_CENTER = "personal-website"
  }
}

resource "aws_subnet" "database_2" {
  vpc_id            = aws_vpc.me.id
  cidr_block        = var.database_subnet_2_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name        = "me-database-subnet-2"
    COST_CENTER = "personal-website"
  }
}

resource "aws_internet_gateway" "me" {
  vpc_id = aws_vpc.me.id

  tags = {
    Name        = "me-internet-gateway"
    COST_CENTER = "personal-website"
  }
}

resource "aws_route_table" "me_public" {
  vpc_id = aws_vpc.me.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.me.id
  }

  tags = {
    Name        = "me-public-route-table"
    COST_CENTER = "personal-website"
  }
}

resource "aws_eip" "me_nat" {
  vpc = true
}
resource "aws_nat_gateway" "me" {
  allocation_id = aws_eip.me_nat.id
  subnet_id     = aws_subnet.public_1.id
  tags = {
    Name        = "me-nat-gateway"
    COST_CENTER = "personal-website"
  }
}

resource "aws_route_table" "me_private" {
  vpc_id = aws_vpc.me.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.me.id
  }

  tags = {
    Name        = "me-private-route-table"
    COST_CENTER = "personal-website"
  }
}

resource "aws_route_table_association" "public_rta_subnet_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.me_public.id
}

resource "aws_route_table_association" "public_rta_subnet_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.me_public.id
}

resource "aws_route_table_association" "private_rta_subnet_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.me_private.id
}

resource "aws_route_table_association" "private_rta_subnet_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.me_private.id
}

resource "aws_route_table_association" "private_rta_subnet_3" {
  subnet_id      = aws_subnet.private_3.id
  route_table_id = aws_route_table.me_private.id
}
