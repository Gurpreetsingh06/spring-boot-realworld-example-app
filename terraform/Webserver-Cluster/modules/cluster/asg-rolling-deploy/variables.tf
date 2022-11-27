variable "instance_type" {
  description = "The type of EC2 instance to run"
  type = string
}

variable "min_size" {
  description = "The minimum number of EC2 instances in the ASG"
  type = number
}

variable "max_size" {
  description = "The maximum number of EC2 instances in the ASG"
  type = number
}

variable "custom_tags" {
  description = "Custom tags to set on the instances in ASG"
  type = map(string)
  default = {}
}

variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
  type = bool
}

variable "server_port" {
  default = 8080
}

variable "ami" {
  description = "The AMI to run in the cluster"
  type = string
  default = "ami-07ebfd5b3428b6f4d"
}

variable "cluster_name" {
  description = "The name to use for all cluster resources"
  type = string
}

variable "subnet_ids" {
  description = "The subnet IDs to deploy to"
  type = list(string)
}

variable "target_group_arns" {
  description = "The ARNs of ELB target groups in which to register instances"
  type = list(string)
  default = []
}

variable "health_check_type" {
  description = "The type of health check to perform. Must be one of: EC2, ELB"
  type = string
  default = "EC2"
}

variable "user_data" {
  description = "The user data script to run in each instance at boot"
  type = string
  default = null
}

locals {
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}



