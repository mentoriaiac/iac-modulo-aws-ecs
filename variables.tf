variable "create_cluster" {
  type        = bool
  default     = true
  description = "Define se cluster será criado"
}

variable "cluster_name" {
  type        = string
  description = "Nome do cluster ecs"
}

variable "container_insights" {
  type        = bool
  default     = true
  description = "Usado para habilitar CloudWatch Container Insights para o cluster"
}

variable "delete_protection" {
  type        = bool
  default     = false
  description = "Impede que terraform exclua o load balance"
}

variable "service_name" {
  type        = string
  description = "Nome do service cluster que será criado"
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
  type        = list(string)
  description = "Id da subnet"
}

variable "vpc_id" {
  type        = string
  description = "Id da vpc"
}

variable "container1_port" {
  type        = number
  description = "Porta que será utilizada pelo Container 1"
}

variable "container1_name" {
  type        = string
  description = "Nome do Container 1"
}

variable "container1_image" {
  type        = string
  description = "Imagem do Container 1"
}

variable "container_cpu" {
  type        = number
  description = "CPU do Container"
}

variable "container_memory" {
  type        = number
  description = "Memória do Container"
}

variable "protocol" {
  type        = string
  description = "Protocolo que será utilizado na aplicação <http, https, tcp>"
}

variable "policy_ssl" {
  type        = string
  default     = null
  description = "Nome da política SSL. Obrigatório se o protocolo for HTTPS ou TLS"
}

variable "certificate_arn" {
  type        = string
  default     = null
  description = "ARN do certificado de servidor SSL padrão"
}

variable "tags" {
  type        = map(string)
  description = "Tags para recursos"
}

variable "parameters" {
  type = list(string)
}