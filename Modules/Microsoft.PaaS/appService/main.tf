#Data source for app service plan that already exists
data "azurerm_app_service_plan" "app_service_plan" {
  name                = var.asp_name
  resource_group_name = var.asp_rsg
}

resource "azurerm_app_service" "app_service" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.rsg
  app_service_plan_id = data.azurerm_app_service_plan.app_service_plan.id
  https_only          = var.https

  site_config {
    dotnet_framework_version = var.dotnet
    always_on                = var.always_on
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

