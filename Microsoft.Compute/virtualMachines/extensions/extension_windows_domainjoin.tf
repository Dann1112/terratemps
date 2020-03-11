# Enssure the VNET DNS servers points to the AD servers first.

resource "azurerm_virtual_machine_extension" "loc_env_vm_joindomain" {
  count                      = var.vm_count
  name                       = "JoinDomain"
  virtual_machine_id         = element(azurerm_virtual_machine.loc_env_vm.*.id, count.index)
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true

  settings = <<-BASE_SETTINGS
 {
    "Name": "${var.vm_extension_ad_domain}",
    "User": "${var.vm_extension_ad_domain}\\${var.vm_extension_ad_username}",
    "OUPath": "${var.vm_extension_ad_ou}",
    "Restart": "true",
    "Options": "3"
 }
BASE_SETTINGS


  protected_settings = <<-PROTECTED_SETTINGS
 {
    "Password": "${var.vm_extension_ad_password}"
 }
PROTECTED_SETTINGS

}

