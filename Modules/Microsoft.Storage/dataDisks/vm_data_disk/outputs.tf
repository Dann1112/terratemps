output "data_disk_name" {
  value = azurerm_managed_disk.loc_env_vm_datadisk.*.name
}

output "data_disk_id" {
  value = azurerm_managed_disk.loc_env_vm_datadisk.*.id
}

