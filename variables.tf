variable "location" {
  description = "Location for resources"
  type        = string
}

variable "teamname" {
  description = "Prefix for resources"
  type        = string
}

variable "environment" {
  description = "Environment for resources"
  type        = string
}
variable "private_address_space" {
  description = "CIDR for private address space"
  type        = string
}

variable "vm_size" {
  description = "VM Size"
  type        = string
}

variable "vm_username" {
  description = "Username for VMs"
  type        = string
}

variable "vm_password" {
  description = "Password for VMs"
  type        = string
  sensitive   = true
}

variable "sql_username" {
  description = "Username for SQL Server"
  type        = string
  sensitive   = true
}

variable "sql_password" {
  description = "Password for SQL Server"
  type        = string
  sensitive   = true
}

