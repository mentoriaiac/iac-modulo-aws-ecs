provider "aws" {
  region = "us-east-1"
}

module "ecs_mentoria" {
  source           = "../"
  create_cluster   = true
  app_count        = 1
  fargate_cpu      = 256
  fargate_memory   = 512
  subnet_ids       = ["subnet-0591c222d2edbbf8e", "subnet-0943ea92117af6fbb"]
  vpc_id           = "vpc-01ee78708ff1e26a6"
  protocol         = "HTTP"
  family_name      = "mentoria"
  service_name     = "mentoria"
  cluster_name     = "mentoria"
  container1_name  = "api"
  container1_image = "chnacib/maria-quiteria:3.0"
  container1_port  = 8000
  container2_name  = "db"
  container2_image = "library/postgres:11-alpine"
  container2_port  = 5432
  container3_name  = "tika"
  container3_image = "apache/tika"
  container3_port  = 9998
  container_cpu    = 10
  container_memory = 128

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
