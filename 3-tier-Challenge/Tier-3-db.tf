provider "random" {}
resource "random_string" "random" {
  length  = 10
  special = false
  lower   = true
  upper   = false
}
resource "azurerm_mssql_server" "ysql" {
  name                         = "y-sql-${random_string.random.result}"
  location                     = azurerm_resource_group.yrg.location
  resource_group_name          = azurerm_resource_group.yrg.name
  version                      = "12.0"
  administrator_login          = var.sql_login
  administrator_login_password = var.sql_pass
  minimum_tls_version          = "1.2"
  tags                         = local.common_tags
}

resource "azurerm_mssql_virtual_network_rule" "example" {
  name      = "internal-vnet"
  server_id = azurerm_mssql_server.ysql.id
  subnet_id = azurerm_subnet.ysubnet[1].id
}

resource "azurerm_mssql_database" "ydb" {
  name         = "db-01"
  server_id    = azurerm_mssql_server.ysql.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  sku_name     = "Basic"
}