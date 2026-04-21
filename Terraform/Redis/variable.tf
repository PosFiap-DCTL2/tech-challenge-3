variable "network" {
  description = "Configurações de rede para o Redis"
  type = object({
    subnet_group_id   = string
    security_group_id = string
  })
}