resource "azurerm_resource_group" "yrg" {
  name     = "project1"
  location = "centralindia"
  tags     = local.common_tags
}
resource "azurerm_virtual_network" "yvnet" {
  name                = "vnet-1"
  address_space       = ["192.168.0.0/16"]
  location            = azurerm_resource_group.yrg.location
  resource_group_name = azurerm_resource_group.yrg.name
  tags                = local.common_tags
}
resource "azurerm_subnet" "ysubnet1" {
  name                 = "web-01"
  resource_group_name  = azurerm_resource_group.yrg.name
  virtual_network_name = azurerm_virtual_network.yvnet.name
  address_prefixes     = ["192.168.1.0/24"]
  delegation {
    name = "delegation"

    service_delegation {
      name = "Microsoft.Web/serverFarms"
    }
  }
}

resource "azurerm_subnet" "ysubnet" {
  count                = length(local.subnet_name)
  name                 = local.subnet_name[count.index]
  resource_group_name  = azurerm_resource_group.yrg.name
  virtual_network_name = azurerm_virtual_network.yvnet.name
  address_prefixes     = [local.subnet_address_prefixes[count.index]]
  service_endpoints    = [local.service_endpoints[count.index]]
}
