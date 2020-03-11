resource "azurerm_mysql_server" "mysql_server" {
  name                = lower(var.mysql_server_name)
  location            = var.location
  resource_group_name = var.mysql_rsg

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }

  administrator_login          = var.mysql_username
  administrator_login_password = var.mysql_password

  version         = var.mysql_version
  ssl_enforcement = var.mysql_ssl_enforcement

  sku {
    name     = var.mysql_server_sku
    tier     = var.mysql_server_tier
    family   = var.mysql_server_family
    capacity = var.msyql_server_capcity
  }

  storage_profile {
    storage_mb            = var.mysql_storage_size
    backup_retention_days = var.mysql_backup_retention
    geo_redundant_backup  = var.mysql_backup_redundancy
  }
}

output "mysql_address" {
  value = azurerm_mysql_server.mysql_server.fqdn
}

