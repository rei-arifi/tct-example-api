resource "aws_lb" "api_ext" {
  name               = "${local.name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
    "sg-04e6280606a0209cb", // load-balancer
    "sg-00a5e0d0032cdebb0", // egress
  ]
  subnets            = [
    "subnet-0466538b241f0e6bd", // tct-public-eu-west-1a
    "subnet-0d8fb9b359f723d8b", // tct-public-eu-west-1b
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
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "api_ext_https" {
  load_balancer_arn = aws_lb.api_ext.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.acm_cert

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_ext.arn
  }
}
