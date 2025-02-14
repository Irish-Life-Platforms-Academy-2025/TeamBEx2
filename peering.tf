resource "azurerm_virtual_network_peering" "pub_priv_peering" {
  name                      = "PubToPriv"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.public_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.privatevnet1.id
}

resource "azurerm_virtual_network_peering" "priv_pub_peering" {
  name                      = "PrivToPub"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.privatevnet1.name
  remote_virtual_network_id = azurerm_virtual_network.public_vnet.id
}