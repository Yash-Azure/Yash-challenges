

resource "azurerm_service_plan" "yappplan" {
  name                = var.app_plan_name
  resource_group_name = azurerm_resource_group.yrg.name
  location            = azurerm_resource_group.yrg.location
  os_type             = "Windows"
  tags                = local.common_tags
  sku_name            = "S2"
}

resource "azurerm_app_service_virtual_network_swift_connection" "example" {
  app_service_id = azurerm_windows_web_app.yapp.id
  subnet_id      = azurerm_subnet.ysubnet1.id
}
resource "azurerm_windows_web_app" "yapp" {
  depends_on = [
    azurerm_virtual_network.yvnet
  ]
  name                      = var.app_name
  location                  = azurerm_service_plan.yappplan.location
  service_plan_id           = azurerm_service_plan.yappplan.id
  https_only          = true
  resource_group_name = azurerm_service_plan.yappplan.resource_group_name
  site_config {
    minimum_tls_version = "1.2"
    ip_restriction = [{
      action = "Allow"
      headers = [{
        x_azure_fdid      = []
        x_fd_health_probe = []
        x_forwarded_for   = []
        x_forwarded_host  = []
      }]
      ip_address                = null
      name                      = "FrontDoorOnly"
      priority                  = 1000
      service_tag               = "AzureFrontDoor.Backend"
      virtual_network_subnet_id = null
    }]
    scm_ip_restriction = [{
      action = "Allow"
      headers = [{
        x_azure_fdid      = []
        x_fd_health_probe = []
        x_forwarded_for   = []
        x_forwarded_host  = []
      }]
      ip_address                = null
      name                      = "Subnet1rule"
      priority                  = 2000
      service_tag               = null
      virtual_network_subnet_id = azurerm_subnet.ysubnet1.id
    }]
  }
  tags = local.common_tags
}

output "outputrg" {
  value = azurerm_resource_group.yrg.tags.Owner
}

output "outputsubbnetid" {
  value = azurerm_subnet.ysubnet1.id
}
