output "alb_dns_name" {
  description = "The domain name of the load balancer"
  value = aws_lb.terraform_lb.dns_name
}

output "alb_http_listener_arn" {
  description = "The ARN of the http listener"
  value = aws_lb_listener.terraform_lb_listener.arn
}

output "alb_security_group_id" {
  description = "The ALB Security Group ID"
  value = aws_security_group.lb_sg.id
}
