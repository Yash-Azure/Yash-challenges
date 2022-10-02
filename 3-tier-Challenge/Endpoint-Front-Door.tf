resource "azurerm_frontdoor" "yfd" {
  resource_group_name = azurerm_resource_group.yrg.name
  name                = var.fd_name
  routing_rule {
    name               = "Rule-01"
    accepted_protocols = ["Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["frontend-01"]
    forwarding_configuration {
      forwarding_protocol = "HttpsOnly"
      backend_pool_name   = "Backend-01"
    }
  }
  backend_pool_load_balancing {
    name = "LB-01"
  }
  backend_pool_health_probe {
    name     = "HP-01"
    protocol = "Https"
  }

  backend_pool {
    name = "Backend-01"
    backend {
      host_header = azurerm_windows_web_app.yapp.default_hostname
      address     = azurerm_windows_web_app.yapp.default_hostname
      http_port   = 80
      https_port  = 443
    }
    load_balancing_name = "LB-01"
    health_probe_name   = "HP-01"
  }
  frontend_endpoint {
    name                                    = "frontend-01"
    host_name                               = "${var.fd_name}.azurefd.net"
    web_application_firewall_policy_link_id = azurerm_frontdoor_firewall_policy.ywaf.id
  }
  tags = local.common_tags
}

resource "azurerm_frontdoor_firewall_policy" "ywaf" {
  name                = "waf${azurerm_frontdoor.yfd.name}"
  resource_group_name = azurerm_resource_group.yrg.name
  enabled             = true
  mode                = "Prevention"
  managed_rule {
    type    = "DefaultRuleSet"
    version = "1.0"
  }
  tags = local.common_tags
}