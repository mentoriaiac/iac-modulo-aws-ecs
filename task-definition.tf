resource "aws_ecs_task_definition" "task_cluster" {
  family                   = "${var.family_name}-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  network_mode             = "awsvpc"
  container_definitions    = file(var.template_container)

  tags = local.tags
}
