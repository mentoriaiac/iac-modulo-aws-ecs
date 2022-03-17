variable "cluster_name" {
  type        = string
  default     = "mentoria-iac"
  description = "Nome do cluster ecs"
}

variable "tags" {
  type = map(string)
  default = {
    name = "cluster-ecs-mentoria-iac"
  }
  description = "Tags para recurso"
}

variable "region" {
  type        = string
  default     = "us-west-2"
  description = "Região AWS"
}

variable "service_name" {
  type        = string
  default     = "service-mentoria-iac"
  description = "Nome do service cluster"
}

variable "desired_count" {
  type        = number
  default     = 1
  description = "Números de tarefas em execução task definition"
}

variable "family_name" {
  type        = string
  default     = "mentoria-iac"
  description = "Nome para task definition"
}

variable "fargate_cpu" {
  type        = number
  default     = 256
  description = "Número de CPUs usados na taskde finition"
}

variable "fargate_memory" {
  type        = number
  default     = 512
  description = "Quantidade de memória usada pela task definition"
}
