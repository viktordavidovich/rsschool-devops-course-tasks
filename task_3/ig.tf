# Create an Internet Gateway
resource "aws_internet_gateway" "igw_k8s" {
  vpc_id = aws_vpc.main_vpc_k8s.id

  tags = {
    Name = "main_igw_k8s"
  }
}

# Allocate an Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip_k8s" {}

# Create the NAT Gateway in a public subnet
resource "aws_nat_gateway" "nat_gw_k8s" {
  allocation_id = aws_eip.nat_eip_k8s.id
  subnet_id     = aws_subnet.public_subnet_k8s.id
  depends_on    = [aws_internet_gateway.igw_k8s]

  tags = {
    Name = "main_nat_gw_k8s"
  }
}
