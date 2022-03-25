resource "aws_lb" "iac_lb" {
  name               = "load-balance-${var.cluster_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnet_ids

  enable_deletion_protection = var.delete_protection

  tags = local.tags
}

resource "aws_lb_target_group" "iac_tg" {
  name        = "target-group-${var.cluster_name}"
  port        = var.app_port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "iac_listener" {
  load_balancer_arn = aws_lb.iac_lb.arn
  port              = var.app_port
  protocol          = var.protocol
  ssl_policy        = var.policy_ssl
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.iac_tg.arn
  }
}