resource "azurerm_virtual_machine_extension" "loc_env_vm_windows_cse" {
  count                      = var.vm_count
  name                       = "customizeOS"
  virtual_machine_id         = element(var.vm_id, count.index)
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.9"
  auto_upgrade_minor_version = true

  settings = <<-BASE_SETTINGS
 {
    "fileUris": [
              "https://raxazurescripts.blob.core.windows.net/scripts/customizeWindowsOS.ps1"
      ]
 }
BASE_SETTINGS


  protected_settings = <<-PROTECTED_SETTINGS
 {
   "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File customizeWindowsOS.ps1",
   "storageAccountName": "${var.storage_account}",
   "storageAccountKey": "${var.storage_account_key}"
 }
PROTECTED_SETTINGS

}

