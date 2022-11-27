module "mysql_rds" {
  source = "../../../../modules/data-stores/mysql"
  
  instance_class = "db.t2.micro"
  db_password = "Admin123*!"
}
