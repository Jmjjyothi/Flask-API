provider "aws" {
  region = "us-east-1"  
}

# VPC
resource "aws_vpc" "kubernetes_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "kubernetes-vpc"
  }
}

# Subnet
resource "aws_subnet" "kubernetes_subnet" {
  vpc_id                  = aws_vpc.kubernetes_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a" 
  map_public_ip_on_launch = true

  tags = {
    Name = "kubernetes-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "kubernetes_igw" {
  vpc_id = aws_vpc.kubernetes_vpc.id

  tags = {
    Name = "kubernetes-igw"
  }
}

# Route Table
resource "aws_route_table" "kubernetes_route_table" {
  vpc_id = aws_vpc.kubernetes_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kubernetes_igw.id
  }

  tags = {
    Name = "kubernetes-route-table"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "kubernetes_route_association" {
  subnet_id      = aws_subnet.kubernetes_subnet.id
  route_table_id = aws_route_table.kubernetes_route_table.id
}

# Security Group for Kubernetes Nodes
resource "aws_security_group" "kubernetes_nodes_sg" {
  vpc_id = aws_vpc.kubernetes_vpc.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kubernetes-nodes-sg"
  }
}

# Launch Configuration for Kubernetes Nodes
resource "aws_launch_configuration" "kubernetes_nodes_lc" {
  name = "kubernetes-nodes-lc"
  image_id = "ami-xxxxxxxxxxxxxxxx"  
  instance_type = "t2.micro"
  security_groups = [aws_security_group.kubernetes_nodes_sg.id]

  lifecycle {
    create_before_destroy = true
  }

  metadata_options {
    http_tokens = "required"
  }
}


# Auto Scaling Group for Kubernetes Nodes
resource "aws_autoscaling_group" "kubernetes_nodes_asg" {
  desired_capacity     = 2
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.kubernetes_subnet.id]
  launch_configuration = aws_launch_configuration.kubernetes_nodes_lc.id

  tag {
    key                 = "Name"
    value               = "kubernetes-node"
    propagate_at_launch = true
  }
}

# Output
output "kubernetes_cluster_url" {
  value = aws_autoscaling_group.kubernetes_nodes_asg.name
}
