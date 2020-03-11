# Basic script that disables firewall and formats disks
resource "azurerm_virtual_machine_extension" "loc_env_vm_customizeos" {
  count                      = var.vm_count
  name                       = "customizeOS"
  virtual_machine_id         = element(azurerm_virtual_machine.loc_env_vm.*.id, count.index)
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

# Script for SQL servers that disables firewall and formats disks with 64K block
resource "azurerm_virtual_machine_extension" "loc_env_vm_customizeos" {
  count                      = var.vm_count
  name                       = "customizeOS"
  virtual_machine_id         = element(azurerm_virtual_machine.loc_env_vm.*.id, count.index)
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.9"
  auto_upgrade_minor_version = true

  settings = <<-BASE_SETTINGS
  {
     "fileUris": [
               "https://raxazurescripts.blob.core.windows.net/scripts/customizeSQLOS.ps1"
       ]
  }
BASE_SETTINGS


  protected_settings = <<-PROTECTED_SETTINGS
  {
    "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File customizeSQLOS.ps1",
    "storageAccountName": "${var.storage_account}",
    "storageAccountKey": "${var.storage_account_key}"
  }
PROTECTED_SETTINGS

}

# Script for Web servers that disables firewall, formats disks, and installs IIS
resource "azurerm_virtual_machine_extension" "loc_env_vm_customizeos" {
  count                      = var.vm_count
  name                       = "customizeOS"
  virtual_machine_id         = element(azurerm_virtual_machine.loc_env_vm.*.id, count.index)
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.9"
  auto_upgrade_minor_version = true

  settings = <<-BASE_SETTINGS
  {
     "fileUris": [
               "https://raxazurescripts.blob.core.windows.net/scripts/customizeIISOS.ps1"
       ]
  }
BASE_SETTINGS


  protected_settings = <<-PROTECTED_SETTINGS
  {
    "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File customizeIISOS.ps1",
    "storageAccountName": "${var.storage_account}",
    "storageAccountKey": "${var.storage_account_key}"
  }
PROTECTED_SETTINGS

}

