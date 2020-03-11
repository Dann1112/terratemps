#Code for Recovery Storage Vault
resource "azurerm_recovery_services_vault" "rsv" {
  name                = "EU2-RSV01"
  location            = var.location
  resource_group_name = azurerm_resource_group.mgmt_rsg.name
  sku                 = "standard"

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

