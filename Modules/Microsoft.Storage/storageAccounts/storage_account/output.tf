output "endpoint_url" {
  value = azurerm_storage_account.storage_account.primary_blob_endpoint
}

output "access_key" {
  value = azurerm_storage_account.storage_account.primary_access_key
}

