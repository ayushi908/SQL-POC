variable "instance_name" {
  type = string
}

variable "region" {
  type = string
}

variable "tier" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "database_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "private_service_access" {
  type = any
}
