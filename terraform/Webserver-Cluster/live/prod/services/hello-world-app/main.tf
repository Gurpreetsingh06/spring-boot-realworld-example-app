module "hello_world_app" {
  source = "../../../../modules/services/hello-world-app"
  
  environment = "prod"
  db_remote_state_bucket = "balaji-upandrunning-state"
  db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"
  instance_type = "t2.medium"
  min_size = 2
  max_size = 3
  enable_autoscaling = true
  ami = "ami-0149b2da6ceec4bb0"

  custom_tags = {
    Owner = "prod-user"
    DeployedBy = "terraform"
  }
}
