resource "azurerm_virtual_machine_extension" "loc_env_vm_bginfo" {
  count                      = var.vm_count
  name                       = "BGInfo"
  virtual_machine_id         = element(var.vm_id, count.index)
  publisher                  = "Microsoft.Compute"
  type                       = "BGInfo"
  type_handler_version       = "2.1"
  auto_upgrade_minor_version = true
}

