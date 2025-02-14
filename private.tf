resource "azurerm_virtual_network" "privatevnet1" {
  name                = "${var.prefix}-privatevnet1"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tag
}

resource "azurerm_subnet" "privatesubnet0" {
  name                = "${var.prefix}-privatesubnet0"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.privatevnet1.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "privatesubnet1" {
  name                = "${var.prefix}-privatesubnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.privatevnet1.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_subnet" "privatesubnet2" {
  name                = "${var.prefix}-privatesubnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.privatevnet1.name
  address_prefixes     = ["10.0.2.0/24"]

}

resource "azurerm_network_interface" "privatenic0" {
  name                = "${var.prefix}-privatenic0"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tag

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.privatesubnet0.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "privatenic1" {
  name                = "${var.prefix}-privatenic1"
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
  name                = "${var.prefix}-privatenic2"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tag

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.privatesubnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "privatevm0" {
  name                  = "${var.prefix}-privatevm0"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.privatenic0.id]
  size                  = "Standard_DS1_v2"
  tags                  = var.tag

  os_disk {
    name                 = "myOsDiskvm0"
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

}

resource "azurerm_linux_virtual_machine" "privatevm1" {
  name                  = "${var.prefix}-privatevm1"
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

  computer_name  = "hostname1"
  admin_username = var.vm_username
  admin_password = var.vm_password

  disable_password_authentication = false


}

  resource "azurerm_linux_virtual_machine" "privatevm2" {
  name                  = "${var.prefix}-privatevm2"
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

  computer_name  = "hostname2"
  admin_username = var.vm_username
  admin_password = var.vm_password

  disable_password_authentication = false

}

