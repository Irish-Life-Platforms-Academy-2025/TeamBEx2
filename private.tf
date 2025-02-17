resource "azurerm_virtual_network" "privatevnet1" {
  name                = "${local.prefix}-privatevnet1"
  address_space       = [var.private_address_space]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
}

resource "azurerm_subnet" "privatesubnet0" {
  name                 = "${local.prefix}-privatesubnet0"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.privatevnet1.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "privatesubnet1" {
  name                 = "${local.prefix}-privatesubnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.privatevnet1.name
  address_prefixes     = ["10.0.1.0/24"]

}

# resource "azurerm_public_ip" "vm0-public-ip" {
#  name                = "${local.prefix}-vm0-public-ip"
#  location            = var.location
#  resource_group_name = azurerm_resource_group.rg.name
#  allocation_method   = "Static"
#  sku                 = "Standard"
#}

#resource "azurerm_public_ip" "vm1-public-ip" {
#  name                = "${local.prefix}-vm1-public-ip"
#  location            = var.location
#  resource_group_name = azurerm_resource_group.rg.name
#  allocation_method   = "Static"
#  sku                 = "Standard"
#}

resource "azurerm_network_security_group" "privatesubnet-nsg" {
  name                = "${local.prefix}-network-security-group"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
 security_rule {
    name                       = "HTTP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "subnet1_nsg" {
  subnet_id                 = azurerm_subnet.privatesubnet0.id
  network_security_group_id = azurerm_network_security_group.privatesubnet-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "subnet2_nsg" {
  subnet_id                 = azurerm_subnet.privatesubnet1.id
  network_security_group_id = azurerm_network_security_group.privatesubnet-nsg.id
}

resource "azurerm_network_interface" "privatenic0" {
  name                = "${local.prefix}-privatenic0"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.privatesubnet0.id
    private_ip_address_allocation = "Dynamic"
 #   public_ip_address_id          = azurerm_public_ip.vm0-public-ip.id
  }
}

resource "azurerm_network_interface" "privatenic1" {
  name                = "${local.prefix}-privatenic1"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.privatesubnet1.id
    private_ip_address_allocation = "Dynamic"
  #  public_ip_address_id          = azurerm_public_ip.vm1-public-ip.id
  }
}


resource "azurerm_linux_virtual_machine" "privatevm0" {
  name                  = "${local.prefix}-privatevm0"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.privatenic0.id]
  size                  = var.vm_size
  zone                  = 1
  tags                  = local.tags

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "hostname0"
  admin_username = var.vm_username
  admin_password = var.vm_password

  disable_password_authentication = false

  # Pointing to the locals file for the inline sudo command to install Apache2
  
  custom_data = base64encode(local.custom_data)

}

resource "azurerm_linux_virtual_machine" "privatevm1" {
  name                  = "${local.prefix}-privatevm1"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.privatenic1.id]
  size                  = var.vm_size
  zone                  = 2
  tags                  = local.tags

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "hostname1"
  admin_username = var.vm_username
  admin_password = var.vm_password

  disable_password_authentication = false

  # Pointing to the locals file for the inline sudo command to install Apache2
  
  custom_data = base64encode(local.custom_data)

}


