resource "azurerm_managed_disk" "loc_env_vm_datadisk" {
  count = var.disk_count

  name                = "${var.vm_name}-disk${format("%02d", count.index % var.disk_count + 1)}"
  resource_group_name = var.disk_rsg
  location            = var.location

  storage_account_type = var.disk_type
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

