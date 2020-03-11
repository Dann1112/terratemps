# Ensure that the subnet has service endpoint enabled for Microslft.Sql.
# This cannot be ignored due to a bug in the Azure API.

resource "azurerm_mysql_virtual_network_rule" "mysql_network" {
  name                = var.mysql_vnet_rule_name
  resource_group_name = var.mysql_rsg
  server_name         = azurerm_mysql_server.mysql_server.name
  subnet_id           = data.azurerm_subnet.vnet_subnet.id
}

data "azurerm_subnet" "vnet_subnet" {
  resource_group_name  = var.vnet_rsg
  virtual_network_name = var.vnet_name
  name                 = var.vnet_subnet
}

