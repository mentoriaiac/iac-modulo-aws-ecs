resource "aws_cloudwatch_log_group" "main" {
  name              = "${var.service_name}-log"
  retention_in_days = "7"
  kms_key_id        = null #tfsec:ignore:AWS089

  tags = var.tags
}
