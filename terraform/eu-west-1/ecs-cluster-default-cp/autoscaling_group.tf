resource "aws_autoscaling_group" "default" {
#   availability_zones = ["eu-west-1a", "eu-west-1b"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  vpc_zone_identifier = var.instance_subnets

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = ""
    propagate_at_launch = true
  }
}

resource "aws_ecs_capacity_provider" "capacity_provider" {
  name = "cp-${local.name}"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.default.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 1
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 1
      instance_warmup_period    = 30
    }
  }
}