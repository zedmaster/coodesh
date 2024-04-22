variable "nginx_install_script" {
  description = "Script de instalação dos códigos de inicialização"
  default     = <<EOF
#!/bin/bash
apt-get update -y
apt-get install -y nginx git
git config --global user.name "ubuntu"
git config --global user.email "ubuntu@email.com"
git clone https://github.com/zedmaster/coodesh.git
cp -R coodesh/app/* /var/www/html/
service nginx restart
EOF
}

resource "aws_launch_template" "example" {
  name_prefix   = "example-launch-template-"
  image_id      = "ami-080e1f13689e07408"
  instance_type = "t2.micro"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 8
      volume_type = "gp2"
    }
  }

  user_data = base64encode(var.nginx_install_script)
}

resource "aws_autoscaling_group" "example" {
  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  vpc_zone_identifier = var.subnet_ids
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1                      # Inicia com uma instância, pode ser alterado conforme necessário
  target_group_arns   = [var.target_group_arn] # Vincula o ALB ao grupo de Auto Scaling
}
