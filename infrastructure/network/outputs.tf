output "me_vpc_id" {
  value = aws_vpc.me.id
}

output "public_subnets" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnets" {
  value = [for subnet in aws_subnet.private : subnet.id]
}

output "database_subnets" {
  value = [for subnet in aws_subnet.database : subnet.id]
}
