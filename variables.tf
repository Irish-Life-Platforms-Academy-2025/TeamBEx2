variable "location" {
  description = "Location for resources"
  type        = string
}

variable "rg_name" {
  description = "Name of resource group"
  type        = string
}

variable "prefix" {
  description = "Prefix for resources"
  type        = string
}

variable "public_address_space" {
  description = "CIDR for public address space"
  type        = string
}

variable "private_address_space" {
  description = "CIDR for private address space"
  type        = string
}

variable "resource_count" {
  description = "Number of resources to create"
  type        = number
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

variable "tag" {
  description = "Tag to apply to all resources"
  type        = map(string)
  default = {
    "DeployedBy" = "teamb"
  }
}