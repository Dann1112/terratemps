# See https://www.terraform.io/docs/providers/azurerm/r/app_service_plan.html for App Service Plan Syntax.
# See https://www.terraform.io/docs/providers/azurerm/r/app_service.html for App Service Syntax 

resource "azurerm_app_service_plan" "loc_env_plan01" {
  name                = "EU2-PRD-PLAN01"
  location            = var.location
  resource_group_name = azurerm_resource_group.paas_rsg.name
  kind                = "Windows"

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "customernameappplan"
  location            = var.location
  resource_group_name = azurerm_resource_group.paas_rsg.name
  app_service_plan_id = azurerm_app_service_plan.loc_env_plan01.id

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

