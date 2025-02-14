resource "azurerm_virtual_network" "privatevnet1" {
  name                = "privatevnet1"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tag
}

resource "azurerm_subnet" "privatesubnet1" {
  name                = "privatesubnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.privatevnet1.name
  address_prefixes     = ["10.0.1.0/24"] 
}

resource "azurerm_subnet" "privatesubnet2" {
  name                = "privatesubnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.privatevnet1.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "privatesubnet3" {
  name                = "privatesubnet3"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.privatevnet1.name
  address_prefixes     = ["10.0.3.0/24"]

}

resource "azurerm_network_interface" "privatenic1" {
  name                = "privatenic1"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tag

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.privatesubnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "privatenic2" {
  name                = "privatenic2"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tag

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.privatesubnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "privatenic3" {
  name                = "privatenic3"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tag

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.privatesubnet3.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "privatevm1" {
  name                  = "privatevm1"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.privatenic1.id]
  size                  = "Standard_DS1_v2"
  tags                  = var.tag

  os_disk {
    name                 = "myOsDiskvm1"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "hostname"
  admin_username = "adminuser"
  admin_password = "Password1234!"

  disable_password_authentication = false 

  }

resource "azurerm_linux_virtual_machine" "privatevm2" {
  name                  = "privatevm2"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.privatenic2.id]
  size                  = "Standard_DS1_v2"
  tags                  = var.tag

  os_disk {
    name                 = "myOsDiskvm2"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "hostname"
  admin_username = "adminuser"
  admin_password = "Password1234!"

  disable_password_authentication = false 


  }

  resource "azurerm_linux_virtual_machine" "privatevm3" {
  name                  = "privatevm3"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.privatenic3.id]
  size                  = "Standard_DS1_v2"
  tags                  = var.tag

  os_disk {
    name                 = "myOsDiskvm3"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "hostname"
  admin_username = "adminuser"
  admin_password = "Password1234!"

  disable_password_authentication = false 

  }

