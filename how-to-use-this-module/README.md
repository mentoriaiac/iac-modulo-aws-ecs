# Template de módulo Terraform

### Pré-Requisitos

| Name | Version |
|------|---------|
| [terraform](#requirement\_terraform) | >= 1.0.0 |

### Criar `terrafile.tf`
Crie um arquivo `terraform.tf` com o seguinte conteúdo. E altere os valores das variáveis. 

```hcl
module "ecs_mentoria" {
  source          = "git@github.com:mentoriaiac/iac-modulo-aws-ecs.git?ref=v1.0"
  cria_cluster    = true
  app_port        = 80
  region          = "us-east-1"
  app_count       = 1
  fargate_cpu     = 256
  fargate_memory  = 512
  subnet_ids      = ["<ID_SUBNET_X>", "<ID_SUBNET_Y>"]
  vpc_id          = "<ID_AWS_VPC>"
  protocol        = "HTTP"
  family_name     = "<NAME>"
  service_name    = "<NAME>"
  cluster_name    = "<NAME>"
  template_container = [{
    name      = "<NAME>"
    image     = "<ENDEREÇO_REGISTRER_IMAGEM_DOCKER>"
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
        awslogs-group         = "<NAME>"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "<NAME>"

      }
    }
  }]
}

output "load_balancer_dns_name" {
  value = "http://${module.ecs_mentoria.loadbalance_dns_name}"
}

```

### Provisionando Cluster ECS
Após preencher os valores requiridos utilize os comandos abaixo para provisonar cluster e suas aplicação.

```shell
terraform init 
terraform fmt
terraform validate
terraform plan
terraform apply
```

### Descrição dos comandos:
Segue uma breve descrição dos comandos listados acima. 
>**terraform init**: Execute o terraform init para baixar todos os plugins necessários.

>**terraform fmt**: O comando é usado para reescrever os arquivos de configuração do Terraform para um formato e estilo canônicos.

>**terraform validate**: Comando valida sintaticamente os arquivos de configuração em um diretório.

>**terraform plan**: Executar um plano de terraform e colocá-lo em um arquivo chamado plano.

>**terraform apply**: Usa plano para aplicar as alterações na AWS.
