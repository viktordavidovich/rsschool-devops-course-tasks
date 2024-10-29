data "aws_security_group" "public_sg_k8s" {
  name = aws_security_group.public_sg_k8s.name
}

data "aws_security_group" "private_sg_k8s" {
  name = aws_security_group.private_sg_k8s.name
}

resource "aws_instance" "public_instance_bastion_k8s" {
  ami                         = "ami-0866a3c8686eaeeba"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_k8s.id
  key_name                    = "rsschool-task-2"
  associate_public_ip_address = true
  security_groups             = [data.aws_security_group.public_sg_k8s.id]
  vpc_security_group_ids      = [aws_security_group.public_sg_k8s.id]
  availability_zone           = var.availability_zones[0]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo ufw disable
              mkdir -p /home/ubuntu/.ssh
              echo "${var.private_key}" > /home/ubuntu/.ssh/rsschool-task-2.pem
              chmod 400 /home/ubuntu/.ssh/rsschool-task-2.pem
              chown ubuntu:ubuntu /home/ubuntu/.ssh/rsschool-task-2.pem
              EOF

  tags = {
    Name = "public_instance_bastion_k8s"
  }


}

resource "aws_instance" "private_instance_k8s" {
  ami                    = "ami-0866a3c8686eaeeba"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet_k8s.id
  availability_zone      = var.availability_zones[0]
  key_name               = "rsschool-task-2"
  vpc_security_group_ids = [aws_security_group.private_sg_k8s.id]

  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt-get install -y curl
                sudo ufw disable
                curl -sfL https://get.k3s.io | sh -
                sudo chmod 644 /etc/rancher/k3s/k3s.yaml
                EOF

  tags = {
    Name = "private_instance_k8s"
  }
}
