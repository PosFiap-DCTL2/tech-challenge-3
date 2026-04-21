variable "db_password" {
  description = "Senha do banco de dados auth_db"
  type        = string
  default     = "2%IVLq4im$8C"
}

variable "db_username" {
  description = "Nome de usuário do banco de dados auth_db"
  type        = string
  default     = "admin"
}

variable "network" {
  description = "Configurações de rede para o Redis"
  type = object({
    subnet_group_id   = string
    security_group_id = string
  })
}