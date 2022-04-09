provider "aws" {
  region = "us-east-1"
}

module "ecs_mentoria" {
  source          = "../"
  create_cluster    = true
  app_port        = 80
  app_count       = 2
  fargate_cpu     = 256
  fargate_memory  = 512
  subnet_ids      = ["subnet-05342b8a3b251ea1c", "subnet-0f35f1f5648061021"]
  vpc_id          = "vpc-06b39de0b51e65186"
  protocol        = "HTTP"
  family_name     = "mentoria"
  service_name    = "mentoria"
  cluster_name    = "mentoria"
  template_container = [{
    name      = "nginx"
    image     = "nginx"
    cpu       = 128
    memory    = 256
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "mentoria-iac"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "nginx"

      }
    }
  }]
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
