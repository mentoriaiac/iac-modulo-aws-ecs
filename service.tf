resource "aws_ecs_service" "service_cluster" {
  for_each        = var.services
  name            = each.value.name
  cluster         = try(element(aws_ecs_cluster.cluster_iac.*.arn, 0), data.aws_ecs_cluster.main[0])
  task_definition = aws_ecs_task_definition.task_cluster[each.key].arn
  launch_type     = "FARGATE"
  desired_count   = var.app_count

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
    security_groups  = aws_security_group.allow_access[*].id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.iac_tg.id
    container_name   = each.value.name
    container_port   = element(each.value.port_mappings.*.containerPort, 0)
  }

  tags = var.tags

  depends_on = [aws_iam_role.ecs_task_execution_role]
}
