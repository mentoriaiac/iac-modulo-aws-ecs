## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="aws"></a> [aws](#requirement\aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#aws\_aws) | 4.0 |

## Modules

Este modulo permite provisionar cluster ECS.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Nome do cluster ECS | `string` | mentoria-iac | yes |
| tags | Tags para recurso | `map(string)` | n/a | yes |
| region | Região AWS | `string` | us-west-2 | yes |
| service_name | Nome do service cluster | `string` | n/a | yes |
| desired_count | Números de tarefas em execução task definition | `number` | 1 | yes |
| family_name | Nome para task definition | `string` | mentoria-iac | yes |
| fargate_cpu | Número de CPUs usados na taskde finition | `number` | n/a | yes |
| fargate_memory | Quantidade de memória usada pela task definition | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|


## Como usar esse módulo
[Acesse o passo-a-passo](how-to-use-this-module/README.md)

## To do...
### Precisamos criar/definir:
- **cloudwatch_log_group**: precisamos de log_group que será utilizado pela task definition.
- **am_role**: criar uma role que será anexada ao service ecs.
- **iam_policy**: uma policy que permita o container enviar log para cloudwatch.
- **iam_role_policy_attachment**: anexar a police/role.
- **aws_lb**: application loadbalance "será publico ou privado?".
- **lb_listener**: fornece um recurso ouvinte no ALB.
- **lb_target_group**: fornece um target para uso do ALB.
- **VPC**: VPC utilizada para projeto.
- **security_group**: grupo de segurança utilizado no projeto.
- security_group_rule: regras de firewall para ingress do app/alb. 
- ***route53_record**: escopo de dns para projeto. 
continua...
