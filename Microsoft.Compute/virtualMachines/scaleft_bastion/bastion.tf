resource "random_string" "password" {
  length      = 48
  upper       = true
  min_upper   = 5
  lower       = true
  min_lower   = 5
  number      = true
  min_numeric = 5
  special     = false
}

resource "azurerm_public_ip" "bastion" {
  name                = "${local.bastion_name}-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion.name
  allocation_method   = "Static"

  tags = {
    displayName = "Bastion-PublicIP"
    Environment = var.environment
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
    BuildBy     = var.buildby
  }
}

resource "azurerm_network_interface" "bastion" {
  name                = "${local.bastion_name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion.name

  dns_servers = var.dns_servers

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = data.azurerm_subnet.bastion.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion.id
  }

  tags = {
    displayName = "NetworkInterface"
    Environment = var.environment
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
    BuildBy     = var.buildby
  }
}

resource "azurerm_virtual_machine" "bastion" {
  name                = local.bastion_name
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion.name

  network_interface_ids = [azurerm_network_interface.bastion.id]
  vm_size               = var.vm_size

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  os_profile {
    computer_name  = lower(local.bastion_name)
    admin_username = "${lower(local.bastion_name)}-rax"
    admin_password = local.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${local.bastion_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = 32
  }

  tags = {
    DisplayName             = "VirtualMachine"
    BastionScope            = var.bastion_scope
    BastionType             = "ScaleFT"
    Compliance              = "PCI"
    Environment             = var.environment
    BuildDate               = replace(substr(timestamp(), 0, 10), "-", "")
    BuildBy                 = var.buildby
    CostCenter              = "None"
    "RaxAutomation|Exclude" = "Monitoring"
  }
}

resource "azurerm_virtual_machine_extension" "customize_bastion" {
  name                 = "CustomizeServer"
  location             = var.location
  resource_group_name  = azurerm_resource_group.bastion.name
  virtual_machine_name = azurerm_virtual_machine.bastion.name

  publisher                  = "Microsoft.Azure.Extensions"
  type                       = "CustomScript"
  type_handler_version       = "2.0"
  auto_upgrade_minor_version = true

  settings = <<-BASE_SETTINGS
 {
    "fileUris": [
        "https://raxtemplates.blob.core.windows.net/master/resources/scripts/azure-bastionbuilder.sh${var.sas_token}"
    ],
    "commandToExecute": "bash azure-bastionbuilder.sh https://raxtemplates.blob.core.windows.net/master/resources/scripts/ ${var.enrollment_token} ${azurerm_public_ip.bastion.ip_address} '${var.sas_token}'"
 }
BASE_SETTINGS

}

locals {
  bastion_name = "rlb${var.vm_unique_number}-${var.mscloud_subscription_id}-${var.core_account_number}"
  password     = random_string.password.result
}

output "name" {
  value = local.bastion_name
}

output "address" {
  value = azurerm_public_ip.bastion.ip_address
}

output "username" {
  value = "${local.bastion_name}-rax"
}

output "password" {
  value = local.password
}

