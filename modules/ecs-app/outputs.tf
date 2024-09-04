# Output ECS Service Name
output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.this.name
}

# Output ECS Task Definition ARN
output "ecs_task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = aws_ecs_task_definition.this.arn
}

# Output ECS Service Desired Count
output "ecs_service_desired_count" {
  description = "Desired number of ECS tasks"
  value       = aws_ecs_service.this.desired_count
}
