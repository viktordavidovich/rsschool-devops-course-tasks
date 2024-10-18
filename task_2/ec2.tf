data "aws_security_group" "public_sg" {
  name = aws_security_group.public_sg.name
}

data "aws_security_group" "private_sg" {
  name = aws_security_group.private_sg.name
}

# EC2 Instances in Public Subnets
resource "aws_instance" "public_instance_1" {
  ami                         = "ami-0866a3c8686eaeeba"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_1.id
  key_name                    = "rsschool-task-2"
  associate_public_ip_address = true
  security_groups             = [data.aws_security_group.public_sg.id]

  tags = {
    Name = "public_instance_1"
  }
}

resource "aws_instance" "public_instance_2" {
  ami             = "ami-0866a3c8686eaeeba"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public_subnet_2.id
  key_name        = "rsschool-task-2"
  security_groups = [data.aws_security_group.public_sg.id]

  tags = {
    Name = "public_instance_2"
  }
}

# EC2 Instances in Private Subnets
resource "aws_instance" "private_instance_1" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet_1.id
  # Specify the key pair name
  key_name        = "rsschool-task-2"
  security_groups = [data.aws_security_group.private_sg.id]


  tags = {
    Name = "private_instance_1"
  }
}

resource "aws_instance" "private_instance_2" {
  ami             = "ami-0866a3c8686eaeeba"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private_subnet_2.id
  key_name        = "rsschool-task-2"
  security_groups = [data.aws_security_group.private_sg.id]

  tags = {
    Name = "private_instance_2"
  }
}










