resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "${local.prefix}-ex2-rg"
  tags     = local.tags
}