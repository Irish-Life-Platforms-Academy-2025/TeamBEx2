resource "azurerm_dns_zone" "dns" {
  name                = "${local.prefix}.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_dns_a_record" "www_record" {
  name                = "www"
  resource_group_name = azurerm_resource_group.rg.name

  zone_name          = azurerm_dns_zone.dns.name
  ttl                = 300
  target_resource_id = azurerm_public_ip.lb_pip.id
}
