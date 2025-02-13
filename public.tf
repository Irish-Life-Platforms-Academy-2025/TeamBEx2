locals {
    split_cidr = split(".", var.public_address_space)
    subnet_base = "${local.split_cidr[0]}.${local.split_cidr[1]}"
}

resource "azurerm_virtual_network" "public_vnet" {
  name = "${var.prefix}-public-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  address_space = [var.public_address_space]
}

resource "azurerm_subnet" "subnets" {
  count = var.resource_count

  name = "${var.prefix}-public-subnet-${count.index}"
  virtual_network_name = azurerm_virtual_network.public_vnet.name
  resource_group_name = azurerm_resource_group.rg.name
  address_prefixes = ["${local.subnet_base}.${count.index}.0/24"]
}