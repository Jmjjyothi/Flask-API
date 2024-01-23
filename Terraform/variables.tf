variable "aws_region" {
  description = "AWS region where the infrastructure is be deployed"
  default     = "us-east-1" 
}

variable "kubernetes_vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "kubernetes_subnet_cidr" {
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "kubernetes_subnet_az" {
  description = "Availability zone for the subnet"
  default     = "us-east-1a"
}

variable "kubernetes_node_instance_type" {
  description = "Instance type for Kubernetes nodes"
  default     = "t2.micro"
}

variable "kubernetes_node_desired_capacity" {
  description = "Desired capacity for the Auto Scaling Group"
  default     = 2
}

variable "kubernetes_node_max_size" {
  description = "Maximum size for the Auto Scaling Group"
  default     = 2
}

variable "kubernetes_node_min_size" {
  description = "Minimum size for the Auto Scaling Group"
  default     = 1
}
