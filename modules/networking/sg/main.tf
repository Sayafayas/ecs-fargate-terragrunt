# Kubernetes worker node SG
resource "aws_security_group" "all_worker_node_groups" {
  name        = "${var.deployment_prefix}-for-all-node-groups-sg"
  vpc_id      = var.vpc_id
  description = "What does this rule enable"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Inbound traffic only from internal VPC"
    cidr_blocks = var.ssh_ingress_cidr_blocks
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.10.0.0/16"]
    description = "What does this rule enable"
  }

  tags = {
    "Name"        = "${var.deployment_prefix}-for-all-node-groups-sg"
    "Description" = "Inbound traffic only from internal VPC"
  }
}

# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "${var.deployment_prefix}-alb-sg"
  vpc_id      = var.vpc_id
  description = "Security Group for the Application Load Balancer"

  # Allow inbound HTTP traffic from anywhere (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "Allow HTTP traffic from anywhere"
    cidr_blocks = var.ssh_ingress_cidr_blocks
  }

  # Allow inbound traffic on the specified ports from specific IPs
  dynamic "ingress" {
    for_each = var.allowed_ingress
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      description = "Allow traffic from specified IPs"
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Egress rules to allow traffic to go out
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    "Name"        = "${var.deployment_prefix}-alb-sg"
    "Description" = "Security Group for the Application Load Balancer"
  }
}

# Security Group for ECS Service/Tasks
resource "aws_security_group" "ecs_sg" {
  name        = "${var.deployment_prefix}-ecs-sg"
  vpc_id      = var.vpc_id
  description = "Security Group for ECS tasks behind the ALB"

  # Egress rules to allow ECS tasks to send outbound traffic (e.g., to databases, APIs)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    "Name"        = "${var.deployment_prefix}-ecs-sg"
    "Description" = "Security Group for ECS tasks"
  }
}

# Allow traffic from ALB to ECS service (on container port)
resource "aws_security_group_rule" "allow_alb_to_ecs" {
  type                     = "ingress"
  from_port                = var.container_port
  to_port                  = var.container_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
  description              = "Allow traffic from ALB to ECS"
}
