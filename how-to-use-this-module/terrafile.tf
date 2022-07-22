
provider "aws" {
  region = "us-east-1"
}

module "ecs_mentoria" {
  source           = "../"
  create_cluster   = true
  app_count        = 1
  fargate_cpu      = 256
  fargate_memory   = 512
  subnet_ids       = ["subnet-08e28abe0bb8c94cc", "subnet-0f22a250f019b5e1d"]
  vpc_id           = "vpc-0bf0d67ed0acdbd2a"
  protocol         = "HTTP"
  family_name      = "mentoria"
  service_name     = "mentoria"
  cluster_name     = "mentoria"
  container1_name  = "api"
  container1_image = "chnacib/mariaquiteria:latest"
  container1_port  = 8000
  container_cpu    = 10
  container_memory = 128
  parameters = ["aws_s3_region", "aws_s3_bucket", "django_secret_key", "django_configuration",
    "aws_s3_bucket_folder", "access_token_lifetime_in_minutes",
    "django_settings_module", "postgres_user", "postgres_endpoint",
    "postgres_name", "postgres_password", "postgres_user",
    "refresh_token_lifetime_in_minutes", "sentry_dsn",
  "spidermon_sentry_fake", "spidermon_telegram_fake"]

  tags = {
    Env          = "production"
    Team         = "tematico-terraform"
    System       = "api-tika"
    CreationWith = "terraform"
    Repository   = "https://github.com/mentoriaiac/iac-modulo-aws-ecs"
  }
}

output "load_balancer_dns_name" {
  value = "http://${module.ecs_mentoria.loadbalance_dns_name}"
}

output "security_group_id" {
  value = module.ecs_mentoria.security_group_id
}

