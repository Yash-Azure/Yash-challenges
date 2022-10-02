resource "azurerm_lb" "ylb" {
  name                = "app-lb"
  resource_group_name = azurerm_resource_group.yrg.name
  location            = azurerm_resource_group.yrg.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "app-fe"
   # public_ip_address_id          = azurerm_public_ip.ypip.id
    subnet_id                     = azurerm_subnet.ysubnet[0].id
    private_ip_address_allocation = Dynamic
  }
}

resource "azurerm_lb_backend_address_pool" "ybackend" {
  name                = "app-pool"
  loadbalancer_id     = azurerm_lb.ylb.id
}

resource "azurerm_lb_probe" "yprobe" {
    name                = "https-probe"
    resource_group_name = azurerm_resource_group.yrg.name
    loadbalancer_id     = azurerm_lb.ylb.id
    protocol            = "TCP"
    port                = "5072"
  }

resource "azurerm_lb_rule" "yrule" {
    name                           = "app-rule"
    resource_group_name = azurerm_resource_group.yrg.name
    loadbalancer_id                = azurerm_lb.ylb.id
    protocol                       = "TCP"
    frontend_port                  = "5072"
    backend_port                   = "5072"
    frontend_ip_configuration_name = "myapp"
    enable_floating_ip             = false
    backend_address_pool_id        = azurerm_lb_backend_address_pool.ybackend.id
    idle_timeout_in_minutes        = 5
    probe_id                       = element(azurerm_lb_probe.azlb.*.id, count.index)
  }

  resource "azurerm_network_interface_backend_address_pool_association" "yaso" {
network_interface_id = azurerm_network_interface.vm[count.index].id
ip_configuration_name = app-vm-${count.index + 1}-config
bbackend_address_pool_id = azurerm_lb_backend_address_pool.ybackend.id
depends_on = [
  azurerm_lb_backend_address_pool
]
  }
