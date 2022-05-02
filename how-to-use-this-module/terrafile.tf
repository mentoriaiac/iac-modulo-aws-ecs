provider "aws" {
  region = "us-east-1"
}

module "ecs_mentoria" {
  source           = "../"
  create_cluster   = true
  app_count        = 1
  fargate_cpu      = 256
  fargate_memory   = 512
  subnet_ids       = ["subnet-00825b5be94f27bfe", "subnet-066dc161feeef4a79"]
  vpc_id           = "vpc-07f5d91b4aa236675"
  protocol         = "HTTP"
  family_name      = "mentoria"
  service_name     = "mentoria"
  cluster_name     = "mentoria"
  container1_name  = "api"
  container1_image = "nginx"
  container1_port  = 80
  container2_name  = "worker"
  container2_image = "rebelthor/sleep"
  container2_port  = 81
  container3_name  = "tika"
  container3_image = "rebelthor/sleep"
  container3_port  = 82
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
