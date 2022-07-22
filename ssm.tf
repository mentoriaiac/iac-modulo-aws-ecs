data "aws_ssm_parameter" "main" {
  for_each = toset(var.parameters)
  name     = "/mariaquiteria/${each.value}"
}