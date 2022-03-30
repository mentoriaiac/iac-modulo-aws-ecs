provider "aws" {
  region  = "us-east-2"
  version = "~> 4.0"
}

terraform {
  backend "s3" {
    bucket = "NOME-BUCKET-S3"
    key    = "path/NOME-APP-terraform-.tfstate"
    region = "us-east-2"
  }
} 

module "ecs_mentoria" {
  source             = "../"
  app_port           = var.APP_PORT
  region             = "us-east-2"
  app_count          = 1
  fargate_cpu        = 256
  fargate_memory     = 512
  subnet_ids         = ["subnet-0378e5fbaf99cf083", "subnet-0f6754a4d9eae615e"]
  security_groups    = ["sg-04d7518e4a0b6fbb4"]
  vpc_id             = "vpc-03b22ad9e62fea94d"
  protocol           = "HTTP"
  policy_ssl         = null
  certificate_arn    = null
  family_name        = var.APP_NAME
  service_name       = var.APP_NAME
  cluster_name       = var.APP_NAME
  template_container = "task-definitions.json"
  tags = {
    name = "cluster-ecs-mentoria-iac"
  }
  
}

output "load_balancer_dns_name" {
  value = "http://${module.ecs_mentoria.loadbalance_dns_name}"
}

data "template_file" "task-definitions_json" {
  template = file("./task-definitions.json")

  vars = {
    APP_VERSION = var.APP_VERSION
    APP_IMAGE   = var.APP_IMAGE
  }
}

variable "APP_NAME" {
  default   = "mentoria_iac"
  description = "Nome da aplicação"
}

variable "APP_IMAGE" {
  default   = "httpd"
  description = "Endereço do registre docker da imagem"
}

variable "APP_VERSION" {
  default   = "alpine3.15"
  description = "Versão da imagem docker"
}

variable "APP_PORT" {
  default   = 80
  description = "Porta do container"
}
