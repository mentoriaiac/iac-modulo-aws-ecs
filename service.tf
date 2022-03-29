resource "aws_ecs_service" "service_cluster" {
  name            = "${var.service_name}-svc"
  cluster         = aws_ecs_cluster.cluster_iac[0].arn
  task_definition = aws_ecs_task_definition.task_cluster.arn
  launch_type     = "FARGATE"
  desired_count   = var.app_count


  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
    security_groups  = var.security_groups
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.iac_tg.id
    container_name   = var.cluster_name
    container_port   = var.app_port
  }

  tags = local.tags

  depends_on = [aws_iam_role.ecs_task_execution_role]
}
