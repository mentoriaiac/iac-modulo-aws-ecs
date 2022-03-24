variable "cluster_name" {
  type        = string
  description = "Nome do cluster ecs"
}

variable "tags" {
  type = map(string)
  description = "Tags para recurso"
}

variable "region" {
  type        = string
  description = "Região AWS"
}

variable "service_name" {
  type        = string
  description = "Nome do service cluster"
}

variable "app_count" {
  type        = number
  description = "Números de tarefas em execução task definition"
}

variable "family_name" {
  type        = string
  description = "Nome para task definition"
}

variable "fargate_cpu" {
  type        = number
  description = "Número de CPUs usados na taskde finition"
}

variable "fargate_memory" {
  type        = number
  description = "Quantidade de memória usada pela task definition"
}

variable "subnet_ids" {
  type    = list(string)

}

variable "security_groups" {
  type    = list(string)

}

variable "vpc_id" {
  type    = string

}

variable "app_port" {
  type    = number

}

variable "protocol" {
  type    = string

}

variable "policy_ssl" {
  type    = string

}

variable "certificate_arn" {
  type    = string

}

variable "template_container" {
  type = string

}