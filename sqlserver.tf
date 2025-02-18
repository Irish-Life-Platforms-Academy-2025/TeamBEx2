resource "azurerm_postgresql_flexible_server" "sql_server" {
  name                          = "${local.prefix}-sqlserver0"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = var.location
  version                       = "13"
  public_network_access_enabled = false
  administrator_login           = var.sql_username
  administrator_password        = var.sql_password
  tags                          = local.tags

  storage_mb = 32768
  sku_name   = "B_Standard_B1ms"
  geo_redundant_backup_enabled  = true
  backup_retention_days = 7

  zone = "1"

  high_availability {
    mode = "ZoneRedundant"    
  }
}
