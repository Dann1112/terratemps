# See https://www.terraform.io/docs/providers/azurerm/r/sql_server.html for SQL Server Syntax.
# See https://www.terraform.io/docs/providers/azurerm/r/mssql_elasticpool.html for Elastic Pool Syntax.

resource "azurerm_sql_server" "sql_server" {
  name                         = "customernamesqlserver" # NOTE: needs to be globally unique. Refer to Naming Standard
  resource_group_name          = azurerm_resource_group.paas_rsg.name
  location                     = azurerm_resource_group.paas_rsg.location
  version                      = "12.0"
  administrator_login          = "customernamesqlserver-adm"
  administrator_login_password = var.admin_password
}

# If using DTU Model

resource "azurerm_mssql_elasticpool" "dtu_elasticpool" {
  name                = "LOC-ENV-POOL"
  resource_group_name = azurerm_resource_group.paas_rsg.name
  location            = azurerm_resource_group.paas_rsg.location
  server_name         = azurerm_sql_server.sql_server.name
  max_size_gb         = "1024"

  sku {
    name     = "StandardPool"
    capacity = 200 #DTUs
    tier     = "Standard"
  }

  per_database_settings {
    min_capacity = 0
    max_capacity = 200
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

#If using Vcore Model

resource "azurerm_mssql_elasticpool" "vcore_elasticpool" {
  name                = "LOC-ENV-POOL"
  resource_group_name = azurerm_resource_group.paas_rsg.name
  location            = azurerm_resource_group.paas_rsg.location
  server_name         = azurerm_sql_server.sql_server.name
  max_size_gb         = "756"

  sku {
    name     = "GP_Gen4"
    capacity = 2
    tier     = "GeneralPurpose"
    family   = "Gen4"
  }

  per_database_settings {
    min_capacity = 0
    max_capacity = 2
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

