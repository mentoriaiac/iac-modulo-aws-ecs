resource "aws_ecs_cluster" "cluster-iac" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    name = var.tags["name"]
  }
}
