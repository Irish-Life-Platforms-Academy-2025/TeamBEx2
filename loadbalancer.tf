resource "azurerm_public_ip" "lb_pip" {
  name                = "${local.prefix}-lb-1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = local.tags

  allocation_method = "Static"
}

resource "azurerm_lb" "lb" {
  name                = "${local.prefix}-lb-1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = local.tags

  sku      = "Standard"
  sku_tier = var.lb_sku_tier

  frontend_ip_configuration {
    name                 = "${local.prefix}-lb-1-fe"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_be_pool" {
  name            = "${local.prefix}-lb-1-be_pool"
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_be_vm0" {
  network_interface_id    = azurerm_network_interface.privatenic0.id
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_be_pool.id
  ip_configuration_name   = "internal"
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_be_vm1" {
  network_interface_id    = azurerm_network_interface.privatenic1.id
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_be_pool.id
  ip_configuration_name   = "internal"
}

resource "azurerm_lb_probe" "lb_probe" {
  name            = "${local.prefix}-lb-1-probe"
  loadbalancer_id = azurerm_lb.lb.id
  port            = 80
}

resource "azurerm_lb_rule" "http_redirect" {
  name                           = "${local.prefix}-lb-1-rule-http"
  loadbalancer_id                = azurerm_lb.lb.id
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_be_pool.id]

  protocol      = "Tcp"
  frontend_port = 80
  backend_port  = 80
  probe_id      = azurerm_lb_probe.lb_probe.id
}