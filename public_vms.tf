resource "azurerm_linux_virtual_machine" "public_vms" {
  count = var.resource_count

  name                  = "${var.prefix}-public-vm-${count.index}"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  network_interface_ids = [azurerm_network_interface.public_nics[count.index].id]
  size                  = var.vm_size
  tags                  = var.tag

  admin_username                  = var.vm_username
  admin_password                  = var.vm_password
  disable_password_authentication = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}