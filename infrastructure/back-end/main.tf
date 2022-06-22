resource "aws_ecs_cluster" "me_services" {
  name = "me-services"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_lb" "me_services" {
  name               = "me-services"
  subnets            = var.public_subnets
  internal           = false
  load_balancer_type = "application"

  security_groups = [module.security_groups.services_elb]

  tags = {
    "Name"      = "me-services"
    COST_CENTER = "personal-website"
  }
}



resource "aws_alb_listener" "me_services" {
  load_balancer_arn = aws_lb.me_services.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = module.chat_service.me_target_group_arn
    type             = "forward"
  }
}

module "roles" {
  source = "./roles"
}

module "chat_service" {
  source                     = "./service"
  vpc_id                     = var.vpc_id
  cluster_id                 = aws_ecs_cluster.me_services.id
  cluster_security_group_ids = [module.security_groups.services_cluster]
  subnet_ids                 = var.public_subnets
  execution_role_arn         = module.roles.execution_arn
}

module "security_groups" {
  source = "./security"
  vpc_id = var.vpc_id

}
