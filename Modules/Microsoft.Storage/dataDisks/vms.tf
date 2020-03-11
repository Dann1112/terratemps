#############################
# IaaS VM
#############################

# Web VM

module "web_vms" {
  source                 = ".//win_vm"
  buildby                = var.buildby
  buildticket            = "Ticket-Number"
  environment            = var.environment
  location               = var.location
  rsg                    = ""
  vnet                   = ""
  subnet                 = ""
  subnet_rsg             = ""
  accelerated_networking = false
  vm_name                = "EU2-PRD-WEB0"
  vm_size                = "Standard_F4s"
  vm_count               = 2
  os_publisher           = "MicrosoftWindowsServer"
  os_offer               = "WindowsServer"
  os_sku                 = "2016-Datacenter"
  vm_disk_sku            = "Premium_LRS"
  vm_timezone            = "Eastern Standard Time"
  admin_password         = var.admin_password
}

#Data Disks for Web VMs

module "eu2_prd_web01_data_disk" {
  source       = ".//vm_data_disk"
  buildby      = var.buildby
  buildticket  = "Ticket-Number"
  environment  = var.environment
  location     = var.location
  disk_rsg     = ""
  vm_name      = "${element(module.web_vms.vm_names, 0)}"
  disk_type    = "Premium_LRS"
  disk_size_gb = 50
  disk_count   = 2
}

module "eu2_prd_web02_data_disk" {
  source       = ".//vm_data_disk"
  buildby      = var.buildby
  buildticket  = "Ticket-Number"
  environment  = var.environment
  location     = var.location
  disk_rsg     = ""
  vm_name      = "${element(module.web_vms.vm_names, 1)}"
  disk_type    = "Premium_LRS"
  disk_size_gb = 50
  disk_count   = 2
}

module "eu2_prd_web01_data_disk_attach" {
  source                    = ".//vm_data_disk_attachment"
  disk_id                   = "${module.eu2_prd_web01_data_disk.data_disk_id}"
  vm_id                     = "${element(module.web_vms.vm_ids, 0)}"
  caching                   = ["None"]
  write_accelerator_enabled = false
  disk_count                = 2
}

module "eu2_prd_web02_data_disk_attach" {
  source                    = ".//vm_data_disk_attachment"
  disk_id                   = "${module.eu2_prd_web02_data_disk.data_disk_id}"
  vm_id                     = "${element(module.web_vms.vm_ids, 1)}"
  caching                   = ["None"]
  write_accelerator_enabled = false
  disk_count                = 2
}
