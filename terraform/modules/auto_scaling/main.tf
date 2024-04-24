variable "nginx_install_script" {
  description = "Script de instalação dos códigos de inicialização"
  default     = <<EOF
#!/bin/bash
apt-get update -y
apt-get install -y nginx git ec2-instance-connect ruby
git config --global user.name "ubuntu"
git config --global user.email "ubuntu@email.com"
git clone https://github.com/zedmaster/coodesh.git
cp -R coodesh/app/* /var/www/html/
service nginx restart
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
chmod +x install
./install auto
service codedeploy-agent status
cat /var/log/aws/codedeploy-agent/codedeploy-agent.log
EOF
}


resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ssm-profile"
  role = aws_iam_role.ssmservice.name
}

resource "aws_iam_role" "ssmservice" {
  name = "ssm-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  ]
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

  network_interfaces {
    associate_public_ip_address = true

    security_groups = [var.security_group_id]
  }

  key_name  = "uzed"
  user_data = base64encode(var.nginx_install_script)


  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_profile.name
  }

  metadata_options {
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    http_endpoint               = "enabled"
  }

  tags = { env = "all" }

}

resource "aws_autoscaling_group" "example" {
  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  name                = "web-auto-scaling"
  vpc_zone_identifier = var.subnet_ids
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1                      # Inicia com uma instância, pode ser alterado conforme necessário
  target_group_arns   = [var.target_group_arn] # Vincula o ALB ao grupo de Auto Scaling
}
