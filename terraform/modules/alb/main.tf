resource "aws_lb" "web" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids
}

# Output the DNS name of the ALB
output "alb_dns_name" {
  value = aws_lb.web.dns_name
}


# Obtendo a lista de IDs das sub-redes
output "subnet_ids" {
  value = var.subnet_ids
}
