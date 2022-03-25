## Infraestrutura
Imagem da infraestrutura do projeto.
![image](./img/ecs-mentoria.png)
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
| [aws_appautoscaling_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appautoscaling_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | resource |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lbhttps://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [locals](https://www.terraform.io/language/values/locals) | input |
| [variables](https://www.terraform.io/language/values/variables) | input |




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

> Precisa adicionar novas variáveis:

## Outputs

| Name | Description |
|------|-------------|


## Como usar esse módulo
[Acesse o passo-a-passo](how-to-use-this-module/README.md)

## To do...
### Precisamos criar/definir:
- **cloudwatch_log_group**: precisamos de log_group que será utilizado pela task definition.
- **iam_role**: criar uma role que será anexada ao service ecs.
- **iam_policy**: uma policy que permita o container enviar log para cloudwatch.
- **iam_role_policy_attachment**: anexar a police/role.
- **VPC**: VPC utilizada para projeto.
- ***route53_record**: escopo de dns para projeto. 

> Continua...
