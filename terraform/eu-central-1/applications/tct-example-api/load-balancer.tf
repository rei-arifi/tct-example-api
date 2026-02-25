resource "aws_lb" "api_ext" {
  name               = "${local.name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
    "sg-0f2afb6dcef8dcce3", // load-balancer
    "sg-0348422414701963a", // egress
  ]
  subnets            = [
    "subnet-0c85acf5db67350b3", // tct-public-eu-central-1a
    "subnet-010b0945e032cb9f3", // tct-public-eu-central-1b
  ]

  enable_deletion_protection = false

  tags = {
    Terraform = "true"
  }
}

resource "aws_lb_listener" "api_ext_http" {
  load_balancer_arn = aws_lb.api_ext.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_ext.arn
  }
}
