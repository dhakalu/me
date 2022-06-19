output "me_vpc_id" {
  value = aws_vpc.me.id
}

output "public_subnets" {
  value = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "private_subnets" {
  value = [aws_subnet.private_1.id, aws_subnet.private_2.id, aws_subnet.private_3.id]
}

output "database_subnets" {
  value = [aws_subnet.database_1.id, aws_subnet.database_2.id]
}
