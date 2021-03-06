# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "netology-ec2" {
  # ссылка на data с подбором образа
  ami           = data.aws_ami.ubuntu.id
  # тип машины
  instance_type = "t2.micro"

  tags = {
    Name = "Netology"

  }
}

# для получения доступа к данным авторизации (Account ID, User ID, and ARN)
data "aws_caller_identity" "current" {}

# для получения данных о регионе
data "aws_region" "current" {}
