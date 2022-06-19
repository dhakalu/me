
locals {
  http_port  = 80
  https_port = 443
  protocal   = "tcp"
  ecs_port   = 5000
  all_ports  = 0
}

resource "aws_security_group" "services_elb" {
  name        = "services-elb"
  description = "SG for services elb"
  vpc_id      = var.vpc_id
  ingress {
    description = "Allow elb to listen to traffic from the internet on port 80"
    from_port   = local.http_port
    to_port     = local.http_port
    protocol    = local.protocal
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = local.all_ports
    to_port          = local.all_ports
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    #
    create_before_destroy = true
  }

  tags = {
    Name = "services-elb"
  }
}

resource "aws_security_group" "services_cluster" {
  name        = "services-cluster"
  description = "SG for traffic between ALB and instances on ECS Cluster"
  vpc_id      = var.vpc_id


  ingress {
    description     = "Inbound rule for all traffic"
    protocol        = "tcp"
    from_port       = local.ecs_port
    to_port         = local.ecs_port
    security_groups = [aws_security_group.services_elb.id]
  }

  egress {
    description = "Allow Internet access to the cluster so Tasks can download images from ECS"
    to_port     = local.https_port
    from_port   = local.https_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "services-cluster"
  }
}
