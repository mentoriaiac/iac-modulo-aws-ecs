
resource "aws_security_group" "allow_access" {
  vpc_id      = var.vpc_id
  name        = "mentoria-sg"
  description = "Permite acesso app mentoria"

  dynamic "ingress" {
    for_each = var.services
    content {
      description = "allow app port"
      from_port   = element(ingress.value.port_mappings.*.containerPort, 0)
      to_port     = element(ingress.value.port_mappings.*.containerPort, 0)
      protocol    = "tcp"
      self        = ingress.value.expose == false
      cidr_blocks = ingress.value.expose ? ["0.0.0.0/0"] : []
    }
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
