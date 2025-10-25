locals {
  container_cpu    = var.cpu / 2
  container_memory = var.memory / 2
}

resource "aws_ecs_cluster" "main" {
  name = "${var.container_name}-${var.environment}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "service" {
  family = "${var.container_name}-${var.environment}-task"

  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role_arn
  requires_compatibilities = ["FARGATE"]

  container_definitions = templatefile("./templates/ecs/app.tftpl", {
    container_name  = "${var.container_name}-${var.environment}-container"
    container_image = var.container_image
    cpu             = local.container_cpu
    memory          = local.container_memory
    app_port        = var.container_port
    aws_region      = var.region
    environment     = var.environment
  })
}

resource "aws_ecs_service" "main" {
  name            = "${var.container_name}-${var.environment}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = var.task_count
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "${var.container_name}-${var.environment}-container"
    container_port   = var.container_port
  }

  network_configuration {
    security_groups  = var.security_group_ids
    subnets          = var.subnet_ids
    assign_public_ip = true
  }
}