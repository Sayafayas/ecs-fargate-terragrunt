output "all_worker_node_groups_sg_id" {
  description = "K8s Nodes SG"
  value       = aws_security_group.all_worker_node_groups.id
}

# Output the ALB security group ID
output "alb_security_group_id" {
  description = "ID of the security group assigned to the ALB"
  value       = aws_security_group.alb_sg.id
}

# Output the ECS security group ID
output "ecs_security_group_id" {
  description = "ID of the security group assigned to the ALB"
  value       = aws_security_group.ecs_sg.id
}
