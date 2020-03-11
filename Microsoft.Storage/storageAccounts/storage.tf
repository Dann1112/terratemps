#boot diag storage account
resource "random_id" "randomId" {
  byte_length = 8
}

resource "azurerm_storage_account" "vmdiagsa" {
  name                     = "${random_id.randomId.hex}diagsa"
  resource_group_name      = azurerm_resource_group.mgmt_rsg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

