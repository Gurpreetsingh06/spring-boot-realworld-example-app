output "db_address" {
  value = aws_db_instance.mysql_rds.address
}

output "db_port" {
  value = aws_db_instance.mysql_rds.port
}

output "db_password" {
  value = var.db_password
}
