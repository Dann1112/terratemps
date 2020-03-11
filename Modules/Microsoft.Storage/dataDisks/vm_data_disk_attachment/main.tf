resource "azurerm_virtual_machine_data_disk_attachment" "loc_env_vm_datadisk_attach" {
  count = var.disk_count

  virtual_machine_id        = var.vm_id
  managed_disk_id           = element(var.disk_id, count.index)
  lun                       = count.index + 1
  caching                   = element(var.caching, count.index)
  write_accelerator_enabled = var.write_accelerator_enabled
  create_option             = "Attach"
}

