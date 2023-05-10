
provider "aws" {
  region = "us-east-1"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0645e6d450ce1bc30"
}

data "aws_subnets" "main" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

module "ecs_mentoria" {
  source          = "../"
  create_cluster  = true
  app_count       = 1
  subnet_ids      = data.aws_subnets.main.ids
  vpc_id          = var.vpc_id
  cluster_name    = "mentoria"
  container1_name = "api"
  container1_port = 8000
  services = {
    "service1" = {
      name                  = "service-test"
      image                 = "nginx:latest"
      cpu                   = "256"
      memory                = "512"
      essential             = true
      environment_variables = []
      port_mappings = [{
        hostPort      = 80
        containerPort = 80
        protocol      = "TCP"
        }
      ]
      health_check = {
        command = [
          "CMD-SHELL",
          "curl -f http://localhost:80/ || exit 1"
        ]
        retries     = 3
        timeout     = 5
        interval    = 15
        startPeriod = 30
      }
      expose = true
    }
  }
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

