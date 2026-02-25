resource "aws_ecs_service" "api" {
  name            = local.name
  cluster         = local.cluster_name
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = 1
  launch_type     = "EC2"
  # iam_role        = aws_iam_role.foo.arn
  # depends_on      = [aws_iam_role_policy.foo]
  
  force_new_deployment = true

  load_balancer {
    target_group_arn = aws_lb_target_group.api_ext.arn
    container_name   = "api"
    container_port   = local.container_port
  }
}

resource "aws_lb_target_group" "api_ext" {
  name     = "${local.name}-ext"
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  deregistration_delay = 30
  target_type = "instance"
  port = local.container_port
  
  health_check {
    path = "/health/live"
  }
}