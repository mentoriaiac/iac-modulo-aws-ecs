resource "aws_ecs_service" "service-cluster" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.cluster-iac.arn
  task_definition = aws_ecs_task_definition.task-cluster.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count
  
  network_configuration {
    subnets = ["subnet-958d90cf"]
  }

  tags = {
    name = var.tags["name"]
  }
}