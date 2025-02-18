resource "azurerm_cdn_frontdoor_profile" "fed_profile" {
  name                = "${local.prefix}-frontdoor-profile"
  resource_group_name = azurerm_resource_group.rg.name
  sku_name = "Standard_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "fd_endpoint" {
    name = "${local.prefix}-frontdoor-endpoint"
    cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fed_profile.id
}