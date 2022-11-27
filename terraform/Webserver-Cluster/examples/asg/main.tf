provider "aws" {
  region  = "us-east-1"
  version = "~> 2.0"
}

terraform {
  required_version = ">= 0.12, < 0.13"
}

module "asg" {
  source = "../../modules/cluster/asg-rolling-deploy"

  cluster_name       = var.cluster_name
  ami                = "ami-0149b2da6ceec4bb0"
  instance_type      = "t2.medium"
  min_size           = 1
  max_size           = 1
  enable_autoscaling = false
  subnet_ids         = data.aws_subnet_ids.default.ids
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

