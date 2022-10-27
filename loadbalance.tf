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
  for_each    = var.services
  name        = "target-group-${each.value.name}"
  port        = element(each.value.port_mappings.*.containerPort, 0)
  protocol    = var.protocol # element(each.value.port_mappings.*.protocol, 0)
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "iac_listener" {
  for_each          = var.services
  load_balancer_arn = aws_lb.iac_lb.arn
  port              = element(each.value.port_mappings.*.containerPort, 0)
  protocol          = var.protocol #tfsec:ignore:AWS004
  ssl_policy        = var.policy_ssl
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.iac_tg[each.key].arn
  }
}
