resource "azurerm_sql_server" "sql_server" {
  name                         = var.name # NOTE: needs to be globally unique. Refer to naming standards.
  resource_group_name          = var.rsg
  location                     = var.location
  version                      = var.ver
  administrator_login          = var.admin_name
  administrator_login_password = var.admin_password
}

