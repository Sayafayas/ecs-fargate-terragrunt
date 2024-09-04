# ALB Configuration
variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
}

variable "subnets" {
  description = "The subnets to attach the ALB to (should be across 2 availability zones)"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs to attach to the ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC where the ALB will be deployed"
  type        = string
}

variable "enable_deletion_protection" {
  description = "Whether to enable deletion protection on the ALB"
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "The idle timeout in seconds for the ALB"
  type        = number
  default     = 60
}

# Target Group Configuration
variable "target_group_port" {
  description = "The port for the target group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "The protocol for the target group"
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "The path for the health check"
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "The interval between health checks"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Timeout for the health check"
  type        = number
  default     = 5
}

variable "health_check_port" {
  description = "Port to perform the health check on"
  type        = string
  default     = "traffic-port"
}

variable "health_check_protocol" {
  description = "Protocol to use for health checks"
  type        = string
  default     = "HTTP"
}

variable "healthy_threshold" {
  description = "Number of consecutive health checks before considering a target healthy"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Number of consecutive health checks before considering a target unhealthy"
  type        = number
  default     = 2
}

# HTTPS Listener Configuration (Optional)
variable "certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS listener"
  type        = string
  default     = ""
}
