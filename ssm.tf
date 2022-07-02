resource "aws_ssm_parameter" "db_passwd" {
  name        = "/maria-quiteria/postgres_password"
  description = "database password"
  type        = "SecureString"
  value       = random_password.postgres_password.result

  tags = var.tags
}

resource "aws_ssm_parameter" "django_key" {
  name        = "/maria-quiteria/django_key"
  description = "django secret key"
  type        = "SecureString"
  value       = random_password.django_key.result

  tags = var.tags
}

resource "random_password" "django_key" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_password" "postgres_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}