output "services_elb" {
  value = aws_security_group.services_elb.id
}

output "services_cluster" {
  value = aws_security_group.services_cluster.id
}
