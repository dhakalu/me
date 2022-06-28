
locals {
  service_name = "me-service-chat"
  launch_type  = "EC2"
  log_group    = "/me/service/chat"
  region       = "us-east-1"
}

resource "aws_lb_target_group" "me_service_chat" {
  name        = "me-service-chat-tg"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    matcher             = 200
    path                = "/predict"
    interval            = 30
  }
}

resource "aws_cloudwatch_log_group" "me_service_chat" {
  name = local.log_group

  tags = {
    service = local.service_name
  }
}

resource "aws_ecs_service" "me_service_chat" {
  name            = local.service_name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.me_service_chat.arn
  desired_count   = 1
  launch_type     = local.launch_type

  load_balancer {
    target_group_arn = aws_lb_target_group.me_service_chat.arn
    container_name   = local.service_name
    container_port   = 5000
  }

  network_configuration {
    security_groups = var.cluster_security_group_ids
    subnets         = var.subnet_ids
  }
}
