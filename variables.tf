variable "location" {
  description = "Location for resources"
  type        = string
  default     = "uksouth"
}

variable "prefix" {
  description = "Prefix for resources"
  type        = string
  default     = "teamb"
}

variable "public_address_space" {
  description = "CIDR for public address space"
  type        = string
  default     = "10.1.0.0/16"
}

variable "resource_count" {
  description = "Number of resources to create"
  type        = number
  default     = 3
}

variable "vm_size" {
  description = "VM Size"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "vm_username" {
  description = "Username for VMs"
  type        = string
}

variable "vm_password" {
  description = "Password for VMs"
  type        = string
}

variable "tag" {
  description = "Tag to apply to all resources"
  type        = map()
  default = {
    "DeployedBy" = "TeamB"
  }
}