provider "aws" {
  region  = "us-east-1"
  version = "~> 2.0"
}

terraform {
  required_version = ">= 0.12, < 0.13"
}

module "asg" {
  source = "../../modules/networking/alb"

  alb_name   = "alb-test"
  subnet_ids = data.aws_subnet_ids.default.ids
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

output "alb_dns" {
  value = module.asg.alb_dns_name
}
