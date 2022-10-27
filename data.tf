data "aws_ecs_cluster" "main" {
  count        = var.create_cluster ? 0 : 1
  cluster_name = var.cluster_name
}