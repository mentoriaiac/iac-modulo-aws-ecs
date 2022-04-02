module "ecs_mentoria" {
  source             = "../"
  cria_cluster       = true
  app_port           = 80
  region             = "us-east-1"
  app_count          = 1
  fargate_cpu        = 256
  fargate_memory     = 512
  subnet_ids         = ["subnet-035ed30de9aa94d50", "subnet-0a1babfef20f80289"]
  security_groups    = ["sg-0086936bdd38617a5"]
  vpc_id             = "vpc-0311033e0d3cb8807"
  protocol           = "HTTP"
  policy_ssl         = null
  certificate_arn    = null
  family_name        = "mentoria"
  service_name       = "mentoria"
  cluster_name       = "mentoria"
  template_container = [{
    name      = "nginx"
    image     = "httpd"
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
}

output "load_balancer_dns_name" {
  value = "http://${module.ecs_mentoria.loadbalance_dns_name}"
}
