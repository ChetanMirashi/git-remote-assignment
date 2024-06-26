resource "aws_db_subnet_group" "assignment-rds-subnet-group" {
  name       = "${var.cloud_env}-${var.db_subnet_group_name}"
  subnet_ids = aws_subnet.assignment_private_test_subnet[*].id

  tags = {
    Name = "${var.cloud_env}-${var.db_subnet_group_name}"
  }
}

resource "aws_db_parameter_group" "assignment-parameter-group" {
  name   = "${var.cloud_env}-${var.db_parameter_group_name}"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "max_connections"
    value = "200"
  }

  tags = {
    Name = "${var.cloud_env}-${var.db_parameter_group_name}"
  }
}

resource "aws_db_option_group" "assignment-option-group" {
  name    = "${var.cloud_env}-${var.db_option_group_name}"
  engine_name = "mysql"
  major_engine_version = "8.0"

  tags = {
    Name = "${var.cloud_env}-${var.db_option_group_name}"
  }
}

resource "aws_db_instance" "assignment-db-instance" {
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  identifier           = "${var.cloud_env}-${var.db_instance_identifier}"
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.assignment-rds-subnet-group.name
  parameter_group_name = aws_db_parameter_group.assignment-parameter-group.name
  option_group_name    = aws_db_option_group.assignment-option-group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true
  publicly_accessible  = false

  tags = {
    Name = "${var.cloud_env}-assignment-database"
  }
}
