resource "aws_security_group" "web" {
  vpc_id      = var.vpc_id
  name        = "web"
  description = "Security group do web server"

  // Regra para permitir o tráfego HTTP (porta 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Permite o acesso de qualquer lugar na Internet
  }

  // Regra para permitir o tráfego HTTPS (porta 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Permite o acesso de qualquer lugar na Internet
  }

}


# Obtendo o ID do Security Group
output "security_group_id" {
  value = aws_security_group.web.id
}


