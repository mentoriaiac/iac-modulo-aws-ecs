resource "aws_ecs_cluster" "cluster_iac" {
  count = var.cria_cluster ? 1 : 0
  name  = var.cluster_name

  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }

  tags = local.tags
}
