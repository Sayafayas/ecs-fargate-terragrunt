# ECS Cluster ID
variable "cluster_id" {
  description = "ID of the ECS cluster"
  type        = string
}

# ECS Task Definition
variable "family" {
  description = "Family name for the ECS task"
  type        = string
}

variable "cpu" {
  description = "The number of CPU units used by the ECS task"
  type        = number
  default     = 256
}

variable "memory" {
  description = "The amount of memory (in MiB) used by the ECS task"
  type        = number
  default     = 512
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_image" {
  description = "Docker image to use for the container"
  type        = string
}

variable "container_port" {
  description = "Port on which the container will listen"
  type        = number
}

variable "container_environment" {
  description = "Environment variables to set in the container"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

# ECS Task Roles
variable "execution_role_arn" {
  description = "ARN of the IAM role that allows ECS to execute tasks"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the IAM role that is assigned to the ECS task"
  type        = string
}

# ECS Service Configuration
variable "desired_count" {
  description = "Number of desired ECS tasks"
  type        = number
  default     = 1
}

variable "subnets" {
  description = "List of subnets for the ECS service"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security groups for the ECS service"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the ECS service"
  type        = bool
  default     = false
}

# Load Balancer (Optional)
variable "alb_target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
  default     = ""
}
