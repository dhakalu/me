resource "aws_vpc" "me" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
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
# TOO EXPENSIVE TO CREATE A NAT GATEWAY for personal website
# resource "aws_nat_gateway" "me" {
#   allocation_id = aws_eip.me_nat.id
#   subnet_id     = aws_subnet.public_1.id
#   tags = {
#     Name        = "me-nat-gateway"
#     COST_CENTER = "personal-website"
#   }
# }

# VPC Endpoint Security Group

# resource "aws_security_group" "vpc_endpoint" {
#   name   = "me-vpce-sg"
#   vpc_id = aws_vpc.me.id
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = [aws_vpc.me.cidr_block]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "me-endpoints-sg"
#   }
# }

# resource "aws_vpc_endpoint" "ecr_api" {
#   for_each = {
#     "ecr-api" : "ecr.api",
#     "ecr-dkr" : "ecr.dkr",
#     "s3" : "s3",
#     "logs" : "logs",
#     "ssm" : "ssm",
#     "secretsmanager" : "secretsmanager",
#     "kms" : "kms",
#   }
#   vpc_id       = aws_vpc.me.id
#   service_name = "com.amazonaws.us-east-1.${each.value}"

#   vpc_endpoint_type  = each.key == "s3" ? "Gateway" : "Interface"
#   subnet_ids         = each.key == "s3" ? null : [aws_subnet.private_1.id, aws_subnet.private_2.id, aws_subnet.private_3.id]
#   route_table_ids    = each.key == "s3" ? [aws_route_table.me_private.id] : null
#   security_group_ids = each.key == "s3" ? null : [aws_security_group.vpc_endpoint.id]

#   tags = {
#     Name        = "me-endpoint-${each.key}"
#     COST_CENTER = "personal-website"
#   }
# }

resource "aws_route_table" "me_private" {
  vpc_id = aws_vpc.me.id

  tags = {
    Name        = "me-private-route-table"
    COST_CENTER = "personal-website"
  }
}

resource "aws_route_table_association" "public" {
  for_each       = toset([aws_subnet.public_1.id, aws_subnet.public_2.id])
  subnet_id      = each.value
  route_table_id = aws_route_table.me_public.id
}


resource "aws_route_table_association" "private" {
  for_each       = toset([aws_subnet.private_1.id, aws_subnet.private_2.id, aws_subnet.private_3.id])
  subnet_id      = each.value
  route_table_id = aws_route_table.me_private.id
}
