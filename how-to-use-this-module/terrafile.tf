
provider "aws" {
  region = "us-east-1"
}

data "template_file" "container_definitions" {
  template = file("./container_definitions.json")
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
  container1_port  = 8000
  container_definitions = data.template_file.container_definitions.rendered

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

