
locals {
  subnet_name             = ["app-01", "db-01"]
  subnet_address_prefixes = ["192.168.2.0/24", "192.168.3.0/24"]
  zones                   = ["1", "2", "3"]
  service_endpoints       = ["Microsoft.sql", "Microsoft.sql"]
  common_tags = {
    "Application Support"  = "yash@abc.com"
    "Owner Supervisor"     = "yash@abc.com"
    "Owner"                = "yash@abc.com"
    "Project Name"         = "Demo_r2"
    "Business Vertical"    = "Demo"
    "SDO Code"             = "123"
    "CC Code"              = "456"
    "Provisioning Request" = "98765"
    "PID"                  = "Shared"
    "Stack"                = "Prod"
  }
  subid = "****"
}