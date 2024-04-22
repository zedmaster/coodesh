variable "security_group_id" {
  description = "ID of the security group associated with the ALB"
}

variable "subnet_ids" {
  description = "Subnets"
}

variable "auto_scaling_arn" {
  description = "Auto Scaling ARN"
}

variable "target_group_arn" {
  description = "Target Group ARN"
}
