variable "db_password" {
  description = "Senha do banco de dados auth_db"
  type        = string
  default     = "5g4$qY21X]u#r7"
}

variable "db_username" {
  description = "Nome de usuário do banco de dados auth_db"
  type        = string
  default     = "dbadmin"
}

variable "network" {
  description = "Configurações de rede para o Redis"
  type = object({
    subnet_group_id   = string
    security_group_id = string
  })
}