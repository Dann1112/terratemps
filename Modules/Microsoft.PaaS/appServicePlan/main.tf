resource "azurerm_app_service_plan" "app_plan" {
  name                = var.asp_name
  location            = var.location
  resource_group_name = var.rsg
  kind                = var.kind

  sku {
    tier     = var.tier
    size     = var.size
    capacity = var.capacity
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

