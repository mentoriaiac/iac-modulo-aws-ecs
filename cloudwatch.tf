resource "aws_cloudwatch_log_group" "main" {
  for_each          = var.services
  name              = "${each.value.name}-log"
  retention_in_days = "7"
  kms_key_id        = null #tfsec:ignore:AWS089

  tags = var.tags
}
