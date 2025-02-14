locals {
  pub_split_cidr  = split(".", var.public_address_space)
  pub_subnet_base = "${local.pub_split_cidr[0]}.${local.pub_split_cidr[1]}"

  priv_split_cidr  = split(".", var.public_address_space)
  priv_subnet_base = "${local.priv_split_cidr[0]}.${local.priv_split_cidr[1]}"
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
  tags                = var.tag
}

resource "azurerm_network_interface" "public_nics" {
  count = var.resource_count

  name                = "${var.prefix}-public-vm-nic-${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tag

  ip_configuration {
    name                          = "public-vm-${count.index}"
    subnet_id                     = azurerm_subnet.public_subnets[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_vm_pips[count.index].id
  }
}

resource "azurerm_network_security_group" "public_nsg" {
  count = var.resource_count

  name                = "${var.prefix}-public-vm-nsg-${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tag
}

resource "azurerm_network_security_rule" "allow_inbound_ssh_rule" {
  count = var.resource_count

  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.public_nsg[count.index].name

  name                       = "AllowInternetSSHToPubSubnet${count.index}"
  priority                   = 200
  direction                  = "Inbound"
  protocol                   = "Tcp"
  access                     = "Allow"
  source_port_range          = "*"
  source_address_prefix      = "*"
  destination_port_range     = "22"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "deny_outbound_vnet_rule" {
  count = var.resource_count

  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.public_nsg[count.index].name

  name                       = "DenyAllTrafficToPrivateVNet"
  priority                   = 510
  direction                  = "Outbound"
  protocol                   = "*"
  access                     = "Deny"
  source_port_range          = "*"
  source_address_prefix      = "*"
  destination_port_range     = "*"
  destination_address_prefix = "10.0.0.0/16"
}

resource "azurerm_network_security_rule" "allow_ssh_vnet_rule" {
  count = var.resource_count

  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.public_nsg[count.index].name

  name                       = "AllowSSHToPrivSubnet"
  priority                   = 500
  direction                  = "Outbound"
  protocol                   = "*"
  access                     = "Allow"
  source_port_range          = "*"
  source_address_prefix      = "*"
  destination_port_range     = "22"
  destination_address_prefix = "${local.priv_subnet_base}.${count.index}.0/24"
}

resource "azurerm_subnet_network_security_group_association" "pub_nsg_assoc" {
  count = var.resource_count

  subnet_id                 = azurerm_subnet.public_subnets[count.index].id
  network_security_group_id = azurerm_network_security_group.public_nsg[count.index].id
}