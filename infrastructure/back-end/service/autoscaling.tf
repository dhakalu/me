resource "aws_launch_template" "me_ecs" {
  image_id = var.ecs_image_id
  iam_instance_profile {
    name = var.ecs_instance_profile
  }
  vpc_security_group_ids = var.cluster_security_group_ids
  user_data              = filebase64("${path.module}/userdata.sh")
  instance_type          = "t2.micro"
  name                   = "me-ecs"
}

resource "aws_autoscaling_group" "me_ecs" {
  name                = "me-services-asg"
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id      = aws_launch_template.me_ecs.id
    version = "$Latest"
  }
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
}
