variable "aws_region" {
  description = "AWS region where the infrastructure is deployed"
  default     = "us-east-1" 
}

variable "flask_api_instance_count" {
  description = "Number of instances for the Flask-API"
  default     = 2 

variable "flask_api_instance_type" {
  description = "Instance type for the Flask API instances"
  default     = "t2.micro" 
