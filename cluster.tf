resource "aws_ecs_cluster" "cluster_iac" {
  count = local.cluster_count
  name  = var.cluster_name

  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }

  tags = var.tags
}
