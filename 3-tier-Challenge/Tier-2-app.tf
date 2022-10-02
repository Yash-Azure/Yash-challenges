resource "azurerm_network_interface" "vm" {
  count               = var.vmcount
  name                = "app-vm-${count.index + 1}-nic"
  resource_group_name = azurerm_resource_group.yrg.name
  location            = azurerm_resource_group.yrg.location
  ip_configuration {
    name                          = "web-vm-ip-${count.index + 1}"
    subnet_id                     = azurerm_subnet.ysubnet[0].id
    private_ip_address_allocation = "Dynamic"
  }
  tags = local.common_tags
}
resource "azurerm_virtual_machine" "yvm" {
  count                 = var.vmcount
  name                  = "app-vm-${count.index + 1}"
  location              = azurerm_resource_group.yrg.location
  resource_group_name   = azurerm_resource_group.yrg.name
  network_interface_ids = [element(azurerm_network_interface.vm.*.id, count.index)]
  zones                 = [element(local.zones, count.index)]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "app-vm-${count.index + 1}-osdisk"
    create_option     = "FromImage"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }
  os_profile {
    computer_name  = "app-vm-${count.index + 1}"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  tags = local.common_tags
}
