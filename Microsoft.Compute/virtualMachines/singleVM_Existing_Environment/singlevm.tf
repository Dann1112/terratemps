#Code to build out complete VM.
# See https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html for syntax.

# availabilty set. Remove this section if there is already an AVSET.
resource "azurerm_availability_set" "loc_env_vm_avset" {
  name                = var.vm_avset
  location            = var.location
  resource_group_name = var.rsg
  managed             = true

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

# Data source for the subnet that already exists
data "azurerm_subnet" "loc_env_vm_subnet" {
  name                 = var.subnet
  virtual_network_name = var.vnet
  resource_group_name  = var.subnet_rsg
}

# NIC
resource "azurerm_network_interface" "loc_env_vm_nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.rsg

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.loc_env_vm_subnet.id
    private_ip_address_allocation = "dynamic"
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

#VM
resource "azurerm_virtual_machine" "loc_env_vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.rsg
  network_interface_ids = [azurerm_network_interface.loc_env_vm_nic.id]
  availability_set_id   = azurerm_availability_set.loc_env_vm_avset.id
  vm_size               = var.vm_size

  # Uncomment the line below to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment the line below to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.vm_disk_sku
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = "${lower(var.vm_name)}-adm"
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
    timezone           = var.vm_timezone
  }

  storage_data_disk {
    name              = "${var.vm_name}-disk1"
    create_option     = "Empty"
    caching           = "None"
    managed_disk_type = var.vm_disk_sku
    disk_size_gb      = 128
    lun               = 0
  }

  storage_data_disk {
    name              = "${var.vm_name}-disk2"
    create_option     = "Empty"
    caching           = "None"
    managed_disk_type = var.vm_disk_sku
    disk_size_gb      = 128
    lun               = 1
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

# Basic script that disables firewall and formats disks. Windows Only
resource "azurerm_virtual_machine_extension" "loc_env_vm_customizeos" {
  name                        = "customizeOS"
  virtual_machine_id          = azurerm_virtual_machine.loc_env_vm.id
  publisher                   = "Microsoft.Compute"
  type                        = "CustomScriptExtension"
  type_handler_version        = "1.9"
  auto_upgrade_minor_version  = true
  depends_on           = [azurerm_virtual_machine.loc_env_vm]

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

#Joins Windows Server to OMS workspace.  Linux uses a different extension.
resource "azurerm_virtual_machine_extension" "loc_env_vm_oms" {
  name                       = "OMSExtension"
  virtual_machine_id         = azurerm_virtual_machine.loc_env_vm.id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_virtual_machine.loc_env_vm]

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

#Windows Only
resource "azurerm_virtual_machine_extension" "loc_env_vm_bginfo" {
  name                       = "BGInfo"
  virtual_machine_id         = azurerm_virtual_machine.loc_env_vm.id
  publisher                  = "Microsoft.Compute"
  type                       = "BGInfo"
  type_handler_version       = "2.1"
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_virtual_machine.loc_env_vm]
}

#Domain Join. Remove if not needed.
resource "azurerm_virtual_machine_extension" "loc_env_vm_joindomain" {
  name                       = "JoinDomain"
  virtual_machine_id         = azurerm_virtual_machine.loc_env_vm.id
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_virtual_machine_extension.loc_env_vm_customizeos]

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

output "loc_env_vm_name" {
  value = azurerm_virtual_machine.loc_env_vm.name
}

output "loc_env_vm_username" {
  value = "${lower(var.vm_name)}-adm"
}

output "loc_env_vm_password" {
  value = var.admin_password
}

output "loc_env_vm_private_ips" {
  value = azurerm_network_interface.loc_env_vm_nic.private_ip_address
}

output "loc_env_vm_rsg" {
  value = azurerm_virtual_machine.loc_env_vm.resource_group_name
}

output "loc_env_vm_location" {
  value = azurerm_virtual_machine.loc_env_vm.location
}

