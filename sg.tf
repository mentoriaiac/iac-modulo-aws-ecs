resource "aws_security_group" "allow_acesso" {
  vpc_id      = var.vpc_id
  name        = element(var.template_container.*.name, 0)
  description = "Permite acesso app ${var.family_name}"

  ingress {
    description = "allow app port"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = local.tags
}
