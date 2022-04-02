resource "aws_cloudwatch_log_group" "main" {
  name              = element(var.template_container.*.logConfiguration.options.awslogs-group,0)
  retention_in_days = "7"

  tags = local.tags
}
