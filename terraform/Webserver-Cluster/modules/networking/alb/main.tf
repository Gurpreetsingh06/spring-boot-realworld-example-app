resource "aws_security_group" "lb_sg" {
  name = var.alb_name
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type = "ingress"
  from_port = local.http_port
  to_port = local.http_port
  protocol = local.tcp_protocol
  cidr_blocks = local.all_ips
  security_group_id = aws_security_group.lb_sg.id
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type = "egress"
  from_port = local.any_port
  to_port = local.any_port
  protocol = local.any_protocol
  cidr_blocks = local.all_ips
  security_group_id = aws_security_group.lb_sg.id
}

resource "aws_lb" "terraform_lb" {
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  name               = var.alb_name
  subnets            = var.subnet_ids
}

resource "aws_lb_listener" "terraform_lb_listener" {
  load_balancer_arn = aws_lb.terraform_lb.arn
  port              = local.http_port
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404; page not found"
      status_code  = "404"
    }
  }
}
