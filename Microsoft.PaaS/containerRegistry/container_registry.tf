resource "azurerm_container_registry" "acr_prd" {
  name                = var.acr_name
  resource_group_name = var.acr_resource_group_name
  location            = azurerm_resource_group.aks_rsg.location
  admin_enabled       = true
  sku                 = var.acr_sku

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

output "acr_login_server" {
  value = azurerm_container_registry.acr_prd.login_server
}

output "acr_admin_username" {
  value = azurerm_container_registry.acr_prd.admin_password
}

output "acr_admin_password" {
  value = azurerm_container_registry.acr_prd.admin_password
}

