terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "allow_ssh" {
    name        = "allow_ssh"
  description = "Allow SSH for external access"
  ingress {
        description      = "SSH from outside"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_http" {
    name        = "allow_80"
    description = "Allow 80 for external access to Web"
    ingress {
    description      = "80 from outside"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
  }
    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_80"
  }
}

resource "aws_instance" "webserver" {
  ami                    = "ami-047e03b8591f2d48a"
  instance_type          = "t2.micro"
  key_name               = "aws_key"
  vpc_security_group_ids 	 = [aws_security_group.allow_ssh.name,aws_security_group.allow_http.name]

  tags = {
    Name = "webserver"
  }
}

output "instance_fqdn" {
  value = aws_instance.webserver.public_dns
}
output "instance_ip_addr" {
  value = aws_instance.webserver.public_ip
}
