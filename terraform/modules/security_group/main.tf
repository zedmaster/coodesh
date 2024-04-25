resource "aws_security_group" "web" {
  vpc_id      = var.vpc_id
  name        = "web"
  description = "Security group do web server"

  # Regra para permitir o tráfego HTTP (porta 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Permite o acesso de qualquer lugar na Internet
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Permite o acesso de qualquer lugar na Internet
  }


  # Permita o tráfego de saúde do ALB
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Permite o acesso de qualquer lugar na Internet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


# Obtendo o ID do Security Group
output "security_group_id" {
  value = aws_security_group.web.id
}


