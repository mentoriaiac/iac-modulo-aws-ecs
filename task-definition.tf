resource "aws_ecs_task_definition" "task_cluster" {
  family                   = var.family_name
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = var.container_definitions
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  tags = var.tags
}
