#Data source for sql server that already exists
data "azurerm_sql_server" "sql_server" {
  name                = var.server_name
  resource_group_name = var.server_rsg
}

resource "azurerm_mssql_elasticpool" "vcore_elasticpool" {
  name                = var.name
  resource_group_name = var.rsg
  location            = var.location
  server_name         = data.azurerm_sql_server.sql_server.name
  max_size_gb         = var.max_size

  sku {
    name     = var.sku_name
    capacity = var.capacity
    tier     = var.tier
    family   = var.family
  }

  per_database_settings {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

