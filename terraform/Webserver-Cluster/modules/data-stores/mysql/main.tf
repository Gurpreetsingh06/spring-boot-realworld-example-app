resource "aws_db_instance" "mysql_rds" {
  identifier_prefix     = "terraform-up-and-running"
  engine                = "mysql"
  allocated_storage     = 10
  instance_class        = var.instance_class
  name                  = "example_database"
  username              = "admin"
  skip_final_snapshot   = true
  password              = var.db_password
  delete_automated_backups = true
  backup_window            = "00:00-01:00"
  backup_retention_period = 30
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
}

resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
}

resource "aws_security_group_rule" "allow_mysql_inbound" {
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_sg.id
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_sg.id
}