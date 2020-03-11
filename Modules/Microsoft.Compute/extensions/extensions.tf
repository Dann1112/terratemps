#BG Info Extension for VM

module "web_vms_bg_info" {
  source   = ".//extension_bginfo"
  vm_id    = "${module.web_vms.vm_ids}"
  vm_count = 2
}

#OMS Extension for Windows VM

module "web_vms_oms" {
  source        = ".//extension_windows_oms"
  vm_id         = "${module.web_vms.vm_ids}"
  vm_count      = 2
  workspace_id  = "${azurerm_log_analytics_workspace.omsworkspace.workspace_id}"
  workspace_key = "${azurerm_log_analytics_workspace.omsworkspace.primary_shared_key}"
}

#OMS Extension for  Linux VM

module "db_vms_oms" {
  source        = ".//extension_linux_oms"
  vm_id         = "${module.db_vms.vm_ids}"
  vm_count      = 2
  workspace_id  = "${azurerm_log_analytics_workspace.omsworkspace.workspace_id}"
  workspace_key = "${azurerm_log_analytics_workspace.omsworkspace.primary_shared_key}"
}

#CSE Extension for Web VM that disables firewall, formats data disks, and also installs IIS

module "web_vms_cse" {
  source              = ".//extension_iis_cse"
  vm_id               = "${module.web_vms.vm_ids}"
  vm_count            = 2
  storage_account     = "raxazurescripts"
  storage_account_key = "https://passwordsafe.corp.rackspace.com/projects/25979/credentials"
}

#CSE Extension for VM that disables firewall and formats data disks

module "app_vms_cse" {
  source              = ".//extension_windows_cse"
  vm_id               = "${module.app_vms.vm_ids}"
  vm_count            = 2
  storage_account     = "raxazurescripts"
  storage_account_key = "https://passwordsafe.corp.rackspace.com/projects/25979/credentials"
}

#CSE Extension for SQL VM that disables firewall and formats data disks in 64K block
module "db_vms_cse" {
  source              = ".//extension_sql_cse"
  vm_id               = "${module.db_vms.vm_ids}"
  vm_count            = 2
  storage_account     = "raxazurescripts"
  storage_account_key = "https://passwordsafe.corp.rackspace.com/projects/25979/credentials"
}
