output "asg_name" {
  description = "The name of the auto scaling group"
  value = aws_autoscaling_group.terraform_asg_example.name
}

output "instance_security_group_id" {
  description = "The ID of the EC2 Instance Security Group"
  value = aws_security_group.terraform_lc_sg.id
}

