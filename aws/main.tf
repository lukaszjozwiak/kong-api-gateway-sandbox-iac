data "aws_ami" "kong" {
  most_recent = true

  filter {
    name   = "name"
    values = ["kong-ee*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "all_traffic" {
  name        = "all-traffic"
  description = "Allow all traffic"

  ingress {
    description = "Allow all inbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "all-traffic"
  }
}

resource "aws_instance" "kong" {
  ami                         = data.aws_ami.kong.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true

  tags = {
    Name = "Kong"
  }

  vpc_security_group_ids = [aws_security_group.all_traffic.id]

  user_data = <<EOF
#!/bin/bash
kong start
  EOF
}
