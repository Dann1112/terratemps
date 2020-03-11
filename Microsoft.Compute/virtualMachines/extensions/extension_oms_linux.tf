resource "azurerm_virtual_machine_extension" "loc_env_vm_oms" {
  count                      = var.vm_count
  name                       = "OMSExtension"
  virtual_machine_id         = element(azurerm_virtual_machine.loc_env_vm.*.id, count.index)
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<-BASE_SETTINGS
 {
   "workspaceId" : "${var.workspace_id}"
 }
BASE_SETTINGS


  protected_settings = <<-PROTECTED_SETTINGS
 {
   "workspaceKey" : "${var.workspace_key}"
 }
PROTECTED_SETTINGS

}

