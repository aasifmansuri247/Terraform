provider "aws" {
  region = "us-east-1"
}

data "template_file" "user_data" {
  template = file("${path.module}/userdata.tpl")
}

resource "aws_instance" "terra_server" {
  ami                         = "ami-020cba7c55df1f615"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.allow_ssh_nginx.id]
  availability_zone           = "us-east-1a"
  subnet_id                   = "subnet-0310b7d86993a61af"
  associate_public_ip_address = true

  user_data = data.template_file.user_data.rendered
  
  tags = {
    Name = "FlaskAppInstance"
  }
}
