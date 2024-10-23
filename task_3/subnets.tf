# Create public subnet for k8s master
resource "aws_subnet" "public_subnet_k8s" {
  vpc_id            = aws_vpc.main_vpc_k8s.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zones[0]

  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_k8s"
  }
}

# Create private subnet in different zone for k8s
resource "aws_subnet" "private_subnet_k8s" {
  vpc_id            = aws_vpc.main_vpc_k8s.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "private_subnet_k8s"
  }
}


