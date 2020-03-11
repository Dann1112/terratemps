#OMS Workspace
# See https://www.terraform.io/docs/providers/azurerm/r/log_analytics_workspace.html for syntax.

resource "azurerm_log_analytics_workspace" "omsworkspace" {
  name                = "${var.coreDevice}-OMS"
  location            = "East US"
  resource_group_name = azurerm_resource_group.mgmt_rsg.name
  sku                 = "pergb2018"

  tags = {
    Group       = "Rackspace"
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

