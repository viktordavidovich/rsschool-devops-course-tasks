# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main_igw"
  }
}

# NAT Gateway for the public subnet
resource "aws_eip" "nat_gateway" {
  domain                    = "vpc"
  associate_with_private_ip = "10.0.0.5"
  depends_on                = [aws_internet_gateway.igw]
}
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "main_ngw"
  }
  depends_on = [aws_eip.nat_gateway]
}