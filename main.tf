provider "aws" {
  region = "us-east-1"
}

data "template_file" "user_data" {
  template = file("${path.module}/userdata.tpl")
}

resource "aws_instance" "terra_server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.allow_ssh_nginx.id]
  availability_zone           = var.availability_zone
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  user_data = data.template_file.user_data.rendered
  
  tags = {
    Name = "FlaskAppInstance"
  }
}
