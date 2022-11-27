terraform {
  backend "s3" {
    key             = "prod/services/webserver-cluster/terraform.tfstate"
    bucket          = "balaji-upandrunning-state"
    dynamodb_table  = "balaji-upandrunning-locks"
    encrypt         = true
    region          = "us-east-1"
  }
}