output "app_plan_id" {
  value = azurerm_app_service_plan.app_plan.id
}

output "app_plan_name" {
  value = azurerm_app_service_plan.app_plan.name
}

output "app_plan_rsg" {
  value = azurerm_app_service_plan.app_plan.resource_group_name
}

