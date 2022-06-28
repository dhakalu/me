variable "vpc_id" {
  type        = string
  description = "VPC ID"
}
variable "cluster_id" {
  type        = string
  description = "Cluster ID"
}

variable "cluster_security_group_ids" {
  type        = list(string)
  description = "Security Groups of the ECS Cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet ids for services"
}

variable "execution_role_arn" {
  type        = string
  description = "Arn of the role that fargate uses to access ECR"
}

variable "ecs_instance_profile" {
  type        = string
  description = "Name of the instance profile to use by the ECS instances"
}

variable "ecs_image_id" {
  type        = string
  description = "Id of the AMI to use to launch instances"
}
