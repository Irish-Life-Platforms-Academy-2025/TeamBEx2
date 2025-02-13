resource "azurerm_virtual_network" "privatevnet1" {
  name                = "privatevnet1"
  address_space       = ["10.0.0.0/16"]
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "privatesubnet1" {
  name                 = "privatesubnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.privatevnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "privatesubnet2" {
  name                 = "privatesubnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.privatevnet1.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "privatesubnet3" {
  name                 = "privatesubnet3"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.privatevnet1.name
  address_prefixes     = ["10.0.3.0/24"]

}

resource "azurerm_network_interface" "privatenic1" {
  name                = "privatenic1"
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.privatesubnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "privatenic2" {
  name                = "privatenic2"
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.privatesubnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "privatenic3" {
  name                = "privatenic3"
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.privatesubnet3.id
    private_ip_address_allocation = "Dynamic"
  }
}