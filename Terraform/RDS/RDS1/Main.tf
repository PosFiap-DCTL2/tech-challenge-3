resource "aws_db_instance" "auth_db" {
  allocated_storage    = 20
  db_name              = "auth_db"
  engine               = "postgres"
  engine_version       = "13.7"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.postgres13"
  skip_final_snapshot  = true

  publicly_accessible    = false
  db_subnet_group_name   = var.network.subnet_group_id
  vpc_security_group_ids = [var.network.security_group_id]
}

# Resta adicionar os dados da tabela sql #