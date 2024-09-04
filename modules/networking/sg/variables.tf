variable "deployment_prefix" {
  description = "Prefix of the deployment"
  type        = string
}

variable "vpc_id" {
  description = "AWS VPC ID"
  type        = string
}

variable "ssh_ingress_cidr_blocks" {
  description = "Allowed CIDR blocks for the SSH for the worker K8s Nodes."
  type        = list(string)
}

variable "container_port" {
  description = "Port on which the container will listen (e.g., 80, 8080)"
  type        = number
  default     = 80
}
