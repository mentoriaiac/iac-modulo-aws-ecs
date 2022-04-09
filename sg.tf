resource "aws_security_group" "allow_access" {
  vpc_id      = var.vpc_id
  name        = var.template_container[0].name
  description = "Permite acesso app ${var.family_name}"

  ingress {
    description = "allow app port"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
  }

  egress {
    description      = "allow app port"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"] #tfsec:ignore:AWS009
    ipv6_cidr_blocks = ["::/0"]      #tfsec:ignore:AWS009
  }

  tags = var.tags
}
