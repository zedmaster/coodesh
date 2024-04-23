resource "aws_lb_target_group" "web" {
  name        = "web-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}


#Output ARN
output "arn" {
  value = aws_lb_target_group.web.arn
}
