locals {
  pub_split_cidr  = split(".", var.public_address_space)
  pub_subnet_base = "${local.pub_split_cidr[0]}.${local.pub_split_cidr[1]}"
}

resource "azurerm_virtual_network" "public_vnet" {
  name                = "${var.prefix}-public-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  address_space       = [var.public_address_space]
  tags                = var.tag
}

resource "azurerm_subnet" "public_subnets" {
  count = var.resource_count

  name                 = "${var.prefix}-public-subnet-${count.index}"
  virtual_network_name = azurerm_virtual_network.public_vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["${local.pub_subnet_base}.${count.index}.0/24"]
}

resource "azurerm_public_ip" "public_vm_pips" {
  count = var.resource_count

  name                = "${var.prefix}-public-vm-pip-${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = "Static"

  tags = var.tag
}

resource "azurerm_network_interface" "public_nics" {
  count = var.resource_count

  name                = "${var.prefix}-public-vm-pip-${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  tags = var.tag
  ip_configuration {
    name                          = "public-vm-${count.index}"
    subnet_id                     = azurerm_subnet.public_subnets[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_vm_pips[count.index].id
  }
}