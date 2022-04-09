resource "aws_cloudwatch_log_group" "main" {
  name              = element(var.template_container.*.logConfiguration.options.awslogs-group, 0)
  retention_in_days = "7"
  kms_key_id        = null #tfsec:ignore:AWS089

  tags = var.tags
}
