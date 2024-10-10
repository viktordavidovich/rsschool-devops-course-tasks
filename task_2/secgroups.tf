# Fetch the prefix list for EC2 Instance Connect (IPv4)
data "aws_ec2_managed_prefix_list" "ec2_instance_connect_ipv4" {
  name = var.ec2_instance_connect_service_name
}

# Security group for public instances to allow SSH and HTTP/HTTPS access
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.main_vpc.id

  # Allow SSH from the EC2 Instance Connect service prefix list
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    prefix_list_ids = [data.aws_ec2_managed_prefix_list.ec2_instance_connect_ipv4.id]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public_sg"
  }
}

# Security group for private instances (no inbound access from outside the VPC)
resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.main_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private_sg"
  }
}