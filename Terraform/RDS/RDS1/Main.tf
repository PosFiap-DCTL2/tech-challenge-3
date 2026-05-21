resource "aws_db_instance" "authdb" {
  identifier          = "authdb"
  allocated_storage   = 20
  db_name             = "authdb"
  engine              = "postgres"
  instance_class      = "db.t3.micro"
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true

  publicly_accessible    = false
  db_subnet_group_name   = var.network.subnet_group_id
  vpc_security_group_ids = [var.network.security_group_id]
}

# Resta adicionar os dados da tabela sql #
