resource "aws_lb" "iac_lb" {
  name                       = "load-balance-${var.cluster_name}"
  internal                   = false #tfsec:ignore:AWS005
  load_balancer_type         = "application"
  security_groups            = aws_security_group.allow_access[*].id
  subnets                    = var.subnet_ids
  drop_invalid_header_fields = true

  enable_deletion_protection = var.delete_protection

  tags = var.tags
}

resource "aws_lb_target_group" "iac_tg" {
  name        = "target-group-${var.cluster_name}"
  port        = var.container1_port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "iac_listener" {
  load_balancer_arn = aws_lb.iac_lb.arn
  port              = var.container1_port
  protocol          = var.protocol #tfsec:ignore:AWS004
  ssl_policy        = var.policy_ssl
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.iac_tg.arn
  }
}
