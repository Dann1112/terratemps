#Automation Account
# See https://www.terraform.io/docs/providers/azurerm/r/automation_account.html for syntax.

resource "azurerm_automation_account" "automation_account" {
  name                = "${var.coreDevice}-OMS-UPDATES"
  location            = var.location
  resource_group_name = azurerm_resource_group.mgmt_rsg.name

  sku_name = "Basic"

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

