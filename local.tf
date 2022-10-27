locals {
  cluster_count = var.create_cluster ? 1 : 0
  cluster_name  = var.create_cluster ? aws_ecs_cluster.cluster_iac[0].name : var.cluster_name
}
