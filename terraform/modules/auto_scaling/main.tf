variable "index_html_content" {
  description = "Conteúdo do arquivo index.html padrão"
  default     = "<html><head><title>Página de Exemplo</title></head><body><h1>Olá, Mundo!</h1><p>Esta é uma página de exemplo.</p></body></html>"
}

variable "nginx_install_script" {
  description = "Script de instalação do Elastic Stack"
  default     = <<EOF
#!/bin/bash
apt-get update
apt-get install -y nginx
apt-get install git
git config --global user.name "ubuntu"
git config --global user.email "ubuntu@email.com"
git clone https://github.com/zedmaster/coodesh.git
service nginx start
EOF
}



resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.id
  vpc_zone_identifier  = var.subnet_ids
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1 # Inicia com uma instância, pode ser alterado conforme necessário
}

# Launch Configuration resource
resource "aws_launch_configuration" "example" {
  image_id        = "ami-00269df8df9e1572c"
  instance_type   = "t2.micro"
  security_groups = [var.security_group_id]
  user_data       = <<-EOF
                     ${var.nginx_install_script}
                     EOF

  lifecycle {
    create_before_destroy = true
  }

}
