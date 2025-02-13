variable "location" {
  description = "Location for resources"
  default     = "uksouth"
}

variable "prefix" {
  description = "Prefix for resources"
  default     = "teamb"
}

variable "public_address_space" {
  description = "CIDR for public address space"
  default     = "10.1.0.0/16"
}

variable "resource_count" {
  description = "Number of resources to create"
  default     = 3
}

variable "vm_size" {
  description = "VM Size"
  default     = "Standard_DS1_v2"
}

variable "tag" {
  description = "Tag to apply to all resources"
  default = {
    "DeployedBy" = "TeamB"
  }
}