#Data source for sql server that already exists
data "azurerm_sql_server" "sql_server" {
  name                = var.server_name
  resource_group_name = var.server_rsg
}

resource "azurerm_sql_database" "sql_database" {
  name                             = var.name
  resource_group_name              = var.rsg
  location                         = var.location
  server_name                      = data.azurerm_sql_server.sql_server.name
  requested_service_objective_name = var.performance
  elastic_pool_name                = var.pool_name
  collation                        = var.collation

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

