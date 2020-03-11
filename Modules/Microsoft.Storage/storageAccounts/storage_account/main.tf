resource "azurerm_storage_account" "storage_account" {
  name                     = lower(var.sa_name)
  resource_group_name      = var.sa_rsg
  location                 = var.location
  account_tier             = var.sa_tier
  account_kind             = var.sa_kind
  account_replication_type = var.sa_replication
  access_tier              = var.sa_access_tier

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

