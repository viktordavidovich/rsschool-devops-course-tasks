# Create a public route table and associate with public subnets
resource "aws_route_table" "public_rt_k8s" {
  vpc_id = aws_vpc.main_vpc_k8s.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_k8s.id
  }

  tags = {
    Name = "public_route_table_k8s"
  }
}
# Associate public route table with public subnets
resource "aws_route_table_association" "public_association_k8s" {
  subnet_id      = aws_subnet.public_subnet_k8s.id
  route_table_id = aws_route_table.public_rt_k8s.id
}

# Create a private route table for private subnets
resource "aws_route_table" "private_rt_k8s" {
  vpc_id = aws_vpc.main_vpc_k8s.id

  tags = {
    Name = "private_route_table_k8s"
  }
}

# Associate private route table with private subnets
resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private_subnet_k8s.id
  route_table_id = aws_route_table.private_rt_k8s.id
}

# Route NAT Gateway
resource "aws_route" "nat-ngw-route" {
  route_table_id         = aws_route_table.private_rt_k8s.id
  nat_gateway_id         = aws_nat_gateway.nat_gw_k8s.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_nat_gateway.nat_gw_k8s]
}
