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
