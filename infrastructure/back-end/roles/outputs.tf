output "execution_arn" {
  value = aws_iam_role.execution.arn
}

output "ecs_instance_profile" {
  value = aws_iam_instance_profile.ecs_agent.name
}
