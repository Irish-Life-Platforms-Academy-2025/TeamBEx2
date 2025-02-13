resource "azurerm_virtual_network" "privatevnet1" {
  name                = "privatevnet1"
  address_space       = ["10.0.0.0/16"]
  location            = "uksouth"
  resource_group_name = "teamb-terraform-rg"
}

resource "azurerm_subnet" "privatesubnet1" {
  name                 = "privatesubnet1"
  resource_group_name  = "teamb-terraform-rg"
  virtual_network_name = "privatevnet1"
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "privatesubnet2" {
  name                 = "privatesubnet2"
  resource_group_name  = "teamb-terraform-rg"
  virtual_network_name = "privatevnet1"
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "privatesubnet3" {
  name                 = "privatesubnet3"
  resource_group_name  = "teamb-terraform-rg"
  virtual_network_name = "privatevnet1"
  address_prefixes     = ["10.0.3.0/24"]

}

resource "azurerm_network_interface" "privatenic1" {
  name                = "privatenic1"
  location            = "uksouth"
  resource_group_name = "teamb-terraform-rg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.privatesubnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "privatenic2" {
  name                = "privatenic2"
  location            = "uksouth"
  resource_group_name = "teamb-terraform-rg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.privatesubnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "privatenic3" {
  name                = "privatenic3"
  location            = "uksouth"
  resource_group_name = "teamb-terraform-rg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.privatesubnet3.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "privatevm1" {
  name                  = "privatevm1"
  location              = "uksouth"
  resource_group_name   = "teamb-terraform-rg"
  network_interface_ids = [azurerm_network_interface.privatenic1.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "privatevm1"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_virtual_machine" "privatevm2" {
  name                  = "privatevm2"
  location              = "uksouth"
  resource_group_name   = "teamb-terraform-rg"
  network_interface_ids = [azurerm_network_interface.privatenic2.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "osdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "privatevm2"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_virtual_machine" "privatevm3" {
  name                  = "privatevm3"
  location              = "uksouth"
  resource_group_name   = "teamb-terraform-rg"
  network_interface_ids = [azurerm_network_interface.privatenic3.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "osdisk3"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "privatevm3"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}