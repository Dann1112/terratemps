#Code to build out complete VM.
# See https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html for syntax.

#boot diag storage account
resource "random_id" "randomId" {
  byte_length = 8
}

resource "azurerm_storage_account" "vmdiagsa" {
  name                     = "${random_id.randomId.hex}diagsa"
  resource_group_name      = azurerm_resource_group.all_rsg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

# availabilty set
resource "azurerm_availability_set" "loc_env_vm_avset" {
  name                = var.vm_avset
  location            = var.location
  resource_group_name = azurerm_resource_group.dmz_rsg.name
  managed             = true

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

# NIC
resource "azurerm_network_interface" "loc_env_vm_nic" {
  count               = var.vm_count
  name                = "${var.vm_name}${count.index + 1}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.dmz_rsg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.dmz.id # "${data.azurerm_subnet.dmz.id}" if using data sources
    private_ip_address_allocation = "Dynamic"
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
  count                 = var.vm_count
  name                  = "${var.vm_name}${count.index + 1}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.dmz_rsg.name
  network_interface_ids = [element(azurerm_network_interface.loc_env_vm_nic.*.id, count.index)]
  availability_set_id   = azurerm_availability_set.loc_env_vm_avset.id
  vm_size               = var.vm_size

  # Uncomment the line below to delete the OS disk automatically when deleting the VM
  #delete_os_disk_on_termination = true

  # Uncomment the line below to delete the data disks automatically when deleting the VM
  #delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.vm_name}${count.index + 1}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.vm_disk_sku
  }
  os_profile {
    computer_name  = "${var.vm_name}${count.index + 1}"
    admin_username = "${lower(var.vm_name)}${count.index + 1}-adm" # or -rax
    admin_password = var.admin_password
  }

  # Uncomment based on OS defined
  os_profile_windows_config {
    provision_vm_agent = true
    timezone           = var.vm_timezone
  }

  # os_profile_linux_config {
  #   disable_password_authentication = false
  # }

  storage_data_disk {
    name              = "${var.vm_name}${count.index + 1}-disk1"
    create_option     = "Empty"
    caching           = "None"
    managed_disk_type = var.vm_disk_sku
    disk_size_gb      = 128
    lun               = 1
  }
  storage_data_disk {
    name              = "${var.vm_name}${count.index + 1}-disk2"
    create_option     = "Empty"
    caching           = "None"
    managed_disk_type = var.vm_disk_sku
    disk_size_gb      = 128
    lun               = 2
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.vmdiagsa.primary_blob_endpoint
  }
  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

output "loc_env_vm_names" {
  value = azurerm_virtual_machine.loc_env_vm.*.name
}

output "loc_env_vm_passwords" {
  value = var.admin_password
}

output "loc_env_vm_private_ips" {
  value = azurerm_network_interface.loc_env_vm_nic.*.private_ip_address
}

output "loc_env_vm_rsg" {
  value = azurerm_virtual_machine.loc_env_vm.*.resource_group_name
}

output "loc_env_vm_location" {
  value = azurerm_virtual_machine.loc_env_vm.*.location
}

