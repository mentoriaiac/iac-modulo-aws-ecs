resource "aws_ecs_task_definition" "task_cluster" {
  for_each                 = var.services
  family                   = format("task-%s", each.value.name)
  requires_compatibilities = ["FARGATE"]
  cpu                      = each.value.cpu
  memory                   = each.value.memory
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode(
    [
      {
        name         = each.value.name
        image        = each.value.image
        cpu          = tonumber(each.value.cpu)
        memory       = tonumber(each.value.memory)
        portMappings = each.value.port_mappings
        essential    = each.value.essential
        environment  = each.value.environment_variables
        healthCheck  = try(each.value.health_check, {})

        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-region        = "${var.region}"
            awslogs-group         = aws_cloudwatch_log_group.main[each.key].name
            awslogs-stream-prefix = "service/${each.value.name}"
          }
        }
      }
    ]
  )
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  tags = var.tags
}
