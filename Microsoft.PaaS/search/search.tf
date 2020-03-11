# https://www.terraform.io/docs/providers/azurerm/r/search_service.html

resource "azurerm_resource_group" "paas_rsg" {
  name     = var.paas_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_search_service" "search" {
  name                = "customername"
  resource_group_name = azurerm_resource_group.paas_rsg.name
  location            = azurerm_resource_group.paas_rsg.location
  sku                 = "free"

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

