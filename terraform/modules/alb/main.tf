resource "aws_lb" "web" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn # Associando o ALB ao Target Group
  }
}

# Output the DNS name of the ALB
output "alb_dns_name" {
  value = aws_lb.web.dns_name
}

#Output ARN
output "arn" {
  value = aws_lb.web.arn
}

# Obtendo a lista de IDs das sub-redes
output "subnet_ids" {
  value = var.subnet_ids
}
