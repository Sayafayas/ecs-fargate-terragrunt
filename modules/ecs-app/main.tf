# ECS Task Definition
resource "aws_ecs_task_definition" "this" {
  family                   = var.family
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([{
    name      = var.container_name
    image     = var.container_image
    cpu       = var.cpu
    memory    = var.memory
    essential = true
    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.container_port
    }]
    environment = var.container_environment
  }])
}

# ECS Service
resource "aws_ecs_service" "this" {
  name            = "${var.family}-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = [aws_lb_target_group_attachment.this]
}

# Optional ALB Target Group Attachment (only if using a load balancer)
resource "aws_lb_target_group_attachment" "this" {
  target_group_arn = var.alb_target_group_arn
  target_id        = aws_ecs_task_definition.this.family
  port             = var.container_port

  depends_on = [aws_ecs_service.this]
}
