# See https://www.terraform.io/docs/providers/azurerm/r/sql_server.html for SQL Server Syntax.

resource "azurerm_resource_group" "paas_rsg" {
  name     = var.paas_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_sql_server" "sql_server" {
  name                         = "customernamesqlprd" # NOTE: needs to be globally unique. Refer to naming standards.
  resource_group_name          = azurerm_resource_group.paas_rsg.name
  location                     = azurerm_resource_group.paas_rsg.location
  version                      = "12.0"
  administrator_login          = "customernamesqlprd-adm"
  administrator_login_password = var.admin_password
}

resource "azurerm_sql_database" "sql_database" {
  name                             = "EU2-PRD-DB1"
  resource_group_name              = azurerm_resource_group.rsg_paas.name
  location                         = azurerm_resource_group.rsg_paas.location
  server_name                      = azurerm_sql_server.sql_server.name
  edition                          = "Standard"
  requested_service_objective_name = "S3"

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}
