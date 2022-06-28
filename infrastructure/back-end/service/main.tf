
locals {
  service_name = "me-service-chat"
  launch_type  = "FARGATE"
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

resource "aws_ecs_task_definition" "me_service_chat" {
  family                   = local.service_name
  requires_compatibilities = [local.launch_type]
  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role_arn
  container_definitions    = <<TASK_DEFINITION
  [
  {
    "name": "${local.service_name}",
    "image": "276499450488.dkr.ecr.us-east-1.amazonaws.com/chat-service:4633cfcd9afdf9307ee350d8028a11fbe8dd7419",
    "cpu": 256,
    "memory": 512,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${local.log_group}",
        "awslogs-region": "${local.region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
TASK_DEFINITION

  tags = {
    Name = local.service_name
  }
}


resource "aws_ecs_service" "me_service_chat" {
  name            = local.service_name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.me_service_chat.arn
  desired_count   = 0
  launch_type     = local.launch_type


  load_balancer {
    target_group_arn = aws_lb_target_group.me_service_chat.arn
    container_name   = local.service_name
    container_port   = 5000
  }

  network_configuration {
    security_groups  = var.cluster_security_group_ids
    subnets          = var.subnet_ids
    assign_public_ip = true
  }
}
