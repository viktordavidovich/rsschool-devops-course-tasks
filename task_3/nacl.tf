# Create network ACL for public subnets
resource "aws_network_acl" "public_nasl_k8s" {
  vpc_id = aws_vpc.main_vpc_k8s.id

  ingress {
    rule_no    = 100
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
    action     = "allow"
  }

  egress {
    protocol   = -1
    rule_no    = 100
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
    action     = "allow"
  }

  tags = {
    Name = "public_nacl_k8s"
  }
}

# Associate NACL with public subnet
resource "aws_network_acl_association" "public_nacl_association" {
  network_acl_id = aws_network_acl.public_nasl_k8s.id
  subnet_id      = aws_subnet.public_subnet_k8s.id
}

# Create network ACL for private subnet
resource "aws_network_acl" "private_nacl_k8s" {
  vpc_id = aws_vpc.main_vpc_k8s.id

  ingress {
    rule_no    = 100
    protocol   = "-1" # All protocols
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
    action     = "allow"
  }

  egress {
    rule_no    = 100
    protocol   = -1
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
    action     = "allow"
  }

  tags = {
    Name = "private_nacl_k8s"
  }
}

# Associate NACL with Private Subnets
resource "aws_network_acl_association" "private_nacl_association_k8s" {
  network_acl_id = aws_network_acl.private_nacl_k8s.id
  subnet_id      = aws_subnet.private_subnet_k8s.id
}
