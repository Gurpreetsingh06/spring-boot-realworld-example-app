resource "aws_security_group" "terraform_lc_sg" {
  name = "${var.cluster_name}-lc-sg"
}

resource "aws_security_group_rule" "allow_8080_inbound" {
  type = "ingress"
  from_port = var.server_port
  to_port = var.server_port
  protocol = local.tcp_protocol
  cidr_blocks = local.all_ips
  security_group_id = aws_security_group.terraform_lc_sg.id
}

resource "aws_security_group_rule" "allow_ssh_inbound" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = local.tcp_protocol
  cidr_blocks = local.all_ips
  security_group_id = aws_security_group.terraform_lc_sg.id
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terraform_lc_sg.id
}

resource "aws_launch_configuration" "terraform_lc_example" {
  image_id        = var.ami
  depends_on = ["aws_cloudwatch_log_group.app_log_group"]
  security_groups = [aws_security_group.terraform_lc_sg.id]
  instance_type   = var.instance_type
  user_data       = var.user_data
  key_name        = "gurpreet-key"
  iam_instance_profile   = aws_iam_instance_profile.ec2_role_profile.name
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "terraform_asg_example" {
  name                 = aws_launch_configuration.terraform_lc_example.name
  launch_configuration = aws_launch_configuration.terraform_lc_example.name
  desired_capacity     = var.min_size
  min_size             = var.min_size
  max_size             = var.max_size
  vpc_zone_identifier  = var.subnet_ids
  health_check_type    = var.health_check_type
  target_group_arns    = var.target_group_arns

  min_elb_capacity = var.min_size

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-asg-example"
    propagate_at_launch = true
  }

  dynamic "tag" {
    // for_each = var.custom_tags
    for_each = {
      for key, value in var.custom_tags:
      key => upper(value)
      if key != "Name"
    }

    content {
      key = tag.key
      value = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_schedule" "scale_out" {
  count = var.enable_autoscaling ? 1 : 0
  autoscaling_group_name = aws_autoscaling_group.terraform_asg_example.name 
  scheduled_action_name = "scale-out-at-morning"
  min_size = 2
  max_size = 4
  desired_capacity = 4
  recurrence = "0 9 * * *"
}

resource "aws_autoscaling_schedule" "scale_in" {
  count = var.enable_autoscaling ? 1 : 0
  autoscaling_group_name = aws_autoscaling_group.terraform_asg_example.name
  scheduled_action_name = "scale-out-at-night"
  min_size = 2
  max_size = 4
  desired_capacity = 2
  recurrence = "0 17 * * *"
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_utilization" {
  alarm_name = "${var.cluster_name}-high-cpu-utilization"
  namespace = "AWS/EC2"
  metric_name = "CPUUtilization"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.terraform_asg_example.name
  }

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = 1
  period = 300
  statistic = "Average"
  threshold = 90
  unit = "Percent"
}

resource "aws_cloudwatch_metric_alarm" "low_cpu_credit_balance" {
  count = format("%.1s", var.instance_type) == "t" ? 1 : 0
  alarm_name = "${var.cluster_name}-low-cpu-credit-balance"
  namespace = "AWS/EC2"
  metric_name = "CPUCreditBalance"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.terraform_asg_example.name
  }

  comparison_operator = "LessThanThreshold"
  evaluation_periods = 1
  period = 300
  statistic = "Minimum"
  threshold = 10
  unit = "Count"
}