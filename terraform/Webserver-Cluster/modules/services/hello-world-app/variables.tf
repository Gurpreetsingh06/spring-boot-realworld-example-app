variable "alb_port" {
  default = 80
}

locals {
  any_port = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips = ["0.0.0.0/0"]
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for database's remote state"
  type = string
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type = string
}


variable "environment" {
  description = "The name of the environment we're deploying to"
  type = string
}

variable "ami" {
  default = "ami-0149b2da6ceec4bb0"
  description = "AMI to deploy to the EC2 instance"
  type = string
}

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