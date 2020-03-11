#Code to build out complete VM.
# See https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html fro syntax.

# Data source for the subnet that already exists
data "azurerm_subnet" "loc_env_vm_subnet" {
  name                 = var.subnet
  virtual_network_name = var.vnet
  resource_group_name  = var.subnet_rsg
}

#Data source for storage account that already exists
data "azurerm_storage_account" "loc_env_vm_sa" {
  name                = var.bootdiagsa
  resource_group_name = var.bootdiagsa_rsg
}

# NIC
resource "azurerm_network_interface" "loc_env_vm_nic" {
  count                         = var.vm_count
  name                          = "${var.vm_name}${count.index + 1}-nic"
  location                      = var.location
  resource_group_name           = var.rsg
  enable_accelerated_networking = var.accelerated_networking

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.loc_env_vm_subnet.id
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
  resource_group_name   = var.rsg
  network_interface_ids = [element(azurerm_network_interface.loc_env_vm_nic.*.id, count.index)]
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  zones   = [element(var.avzone, count.index)]
  vm_size = var.vm_size

  # Uncomment the line below to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment the line below to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
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
    admin_username = "${lower(var.vm_name)}${count.index + 1}-adm"
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = "true"
    timezone           = var.vm_timezone
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = data.azurerm_storage_account.loc_env_vm_sa.primary_blob_endpoint
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

