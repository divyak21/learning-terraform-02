data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["979382823631"] # Bitnami
}

data "aws_vpc" "default"{
  default = true
}
resource "aws_instance" "blog" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type


  vpc_security_group_ids = [aws_security_group.blog.id]

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "blog"{
  name :"blog"
  description:"Allow http and http in. Allow everything out"

  vpc_id = data.aws_vpc.default.id
}

resource       ="aws_security_group_rule" "blog_http_in"{
  type         = "ingress"
  from_port    = 80
  to_port      = 80
  protocol     = "tcp"
  cidir_blocks =["0.0.0.0/0"]

  aws_security_group_id= aws_security_group_blog.id
}

resource       ="aws_security_group_rule" "blog_http_in"{
  type         = "ingress"
  from_port    = 443
  to_port      = 443
  protocol     = "tcp"
  cidir_blocks =["0.0.0.0/0"]

  aws_security_group_id= aws_security_group_blog.id
}

resource       ="aws_security_group_rule" "blog_out"{
  type         = "egress"
  from_port    = 0
  to_port      = 0
  protocol     = "-1"
  cidir_blocks =["0.0.0.0/0"]

  aws_security_group_id= aws_security_group_blog.id
}