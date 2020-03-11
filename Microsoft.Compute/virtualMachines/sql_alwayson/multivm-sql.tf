#This template will build out two SQL servers into an existing enviroment.  A domain will need to be online for these VMs to join.
#A Storage Account will be created as the Cloud File Share Witness

# Boot Diagnostics Storage Account
resource "random_id" "randomId" {
  byte_length = 8
}

resource "azurerm_storage_account" "vmdiagsa" {
  name                     = "${random_id.randomId.hex}diagsa"
  resource_group_name      = var.rsg
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

# Availability Set
resource "azurerm_availability_set" "loc_env_vm_avset" {
  name                = var.sql_avset_name
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

# Network Interfaces
resource "azurerm_network_interface" "loc_env_sql01_nic" {
  name                = "${var.sql1_vm_name}-nic"
  location            = var.location
  resource_group_name = var.rsg

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.loc_env_vm_subnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = element(var.sql_ip_addresses, 0)
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_network_interface" "loc_env_sql02_nic" {
  name                = "${var.sql2_vm_name}-nic"
  location            = var.location
  resource_group_name = var.rsg

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.loc_env_vm_subnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = element(var.sql_ip_addresses, 1)
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

# Virtual Machine
resource "azurerm_virtual_machine" "loc_env_sql01" {
  name                  = var.sql1_vm_name
  location              = var.location
  resource_group_name   = var.rsg
  network_interface_ids = [azurerm_network_interface.loc_env_sql01_nic.id]
  availability_set_id   = azurerm_availability_set.loc_env_vm_avset.id
  vm_size               = var.sql_vm_size

  storage_image_reference {
    publisher = "MicrosoftSQLServer"
    offer     = "SQL2016SP1-WS2016"
    sku       = "Enterprise"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.sql1_vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = var.sql1_vm_name
    admin_username = var.ad_username
    admin_password = var.ad_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
    timezone           = var.sql_timezone
  }

  storage_data_disk {
    name              = "${var.sql1_vm_name}-data01"
    create_option     = "Empty"
    caching           = "ReadOnly"
    managed_disk_type = var.data_disk_sku
    disk_size_gb      = var.data_disk_size
    lun               = 0
  }

  storage_data_disk {
    name              = "${var.sql1_vm_name}-data02"
    create_option     = "Empty"
    caching           = "None"
    managed_disk_type = var.log_disk_sku
    disk_size_gb      = var.log_disk_size
    lun               = 1
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

resource "azurerm_virtual_machine" "loc_env_sql02" {
  name                  = var.sql2_vm_name
  location              = var.location
  resource_group_name   = var.rsg
  network_interface_ids = [azurerm_network_interface.loc_env_sql02_nic.id]
  availability_set_id   = azurerm_availability_set.loc_env_vm_avset.id
  vm_size               = var.sql_vm_size

  storage_image_reference {
    publisher = "MicrosoftSQLServer"
    offer     = "SQL2016SP1-WS2016"
    sku       = "Enterprise"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.sql2_vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = var.sql2_vm_name
    admin_username = var.ad_username
    admin_password = var.ad_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
    timezone           = var.sql_timezone
  }

  storage_data_disk {
    name              = "${var.sql2_vm_name}-data01"
    create_option     = "Empty"
    caching           = "ReadOnly"
    managed_disk_type = var.data_disk_sku
    disk_size_gb      = var.data_disk_size
    lun               = 0
  }

  storage_data_disk {
    name              = "${var.sql2_vm_name}-data02"
    create_option     = "Empty"
    caching           = "None"
    managed_disk_type = var.log_disk_sku
    disk_size_gb      = var.log_disk_size
    lun               = 1
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

#Create Cloud Witness

resource "azurerm_storage_account" "fswsa" {
  name                     = "${random_id.randomId.hex}fswsa"
  resource_group_name      = var.rsg
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

# Create Load Balancer

resource "azurerm_lb" "aoag_lb" {
  name                = "${var.sql_prefix}-LB01"
  location            = var.location
  resource_group_name = var.rsg

  frontend_ip_configuration {
    name                          = "${var.sql_prefix}-LB01-IP"
    subnet_id                     = data.azurerm_subnet.loc_env_vm_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = element(var.sql_ip_addresses, 3)
  }
}

resource "azurerm_lb_backend_address_pool" "aoag_lb" {
  resource_group_name = var.rsg
  loadbalancer_id     = azurerm_lb.aoag_lb.id
  name                = "${azurerm_lb.aoag_lb.name}-BEP"
}

resource "azurerm_lb_probe" "aoag_lb" {
  resource_group_name = var.rsg
  loadbalancer_id     = azurerm_lb.aoag_lb.id
  name                = "${azurerm_lb.aoag_lb.name}-PRB"
  port                = 59999
}

resource "azurerm_lb_rule" "aoag_lb" {
  resource_group_name            = var.rsg
  loadbalancer_id                = azurerm_lb.aoag_lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 1433
  backend_port                   = 1433
  frontend_ip_configuration_name = "${azurerm_lb.aoag_lb.name}-IP"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.aoag_lb.id
  probe_id                       = azurerm_lb_probe.aoag_lb.id
  load_distribution              = "Default"
  enable_floating_ip             = true
}

resource "azurerm_network_interface_backend_address_pool_association" "ilbnic1" {
  network_interface_id    = azurerm_network_interface.loc_env_sql01_nic.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.aoag_lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "ilbnic2" {
  network_interface_id    = azurerm_network_interface.loc_env_sql02_nic.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.aoag_lb.id
}

#Extensions

#BGINFO

resource "azurerm_virtual_machine_extension" "loc_env_sql01_bginfo" {
  name                       = "BGInfo"
  location                   = var.location
  resource_group_name        = var.rsg
  virtual_machine_name       = azurerm_virtual_machine.loc_env_sql01.name
  publisher                  = "Microsoft.Compute"
  type                       = "BGInfo"
  type_handler_version       = "2.1"
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_virtual_machine.loc_env_sql01]
}

resource "azurerm_virtual_machine_extension" "loc_env_sql02_bginfo" {
  name                       = "BGInfo"
  location                   = var.location
  resource_group_name        = var.rsg
  virtual_machine_name       = azurerm_virtual_machine.loc_env_sql02.name
  publisher                  = "Microsoft.Compute"
  type                       = "BGInfo"
  type_handler_version       = "2.1"
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_virtual_machine.loc_env_sql02]
}

#CSE to mount disks and disable firewall. Only run on Windows VMs
resource "azurerm_virtual_machine_extension" "loc_env_sql01_customizeOS" {
  name                 = "customizeOS"
  location             = var.location
  resource_group_name  = var.rsg
  virtual_machine_name = azurerm_virtual_machine.loc_env_sql01.name
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"
  depends_on           = [azurerm_virtual_machine.loc_env_sql01]

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

resource "azurerm_virtual_machine_extension" "loc_env_sql02_customizeOS" {
  name                 = "customizeOS"
  location             = var.location
  resource_group_name  = var.rsg
  virtual_machine_name = azurerm_virtual_machine.loc_env_sql02.name
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"
  depends_on           = [azurerm_virtual_machine.loc_env_sql02]

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

#Create AoAG

resource "azurerm_virtual_machine_extension" "loc_env_sql02_sqlAOPrepare" {
  name                       = "sqlAOPrepare"
  location                   = var.location
  resource_group_name        = var.rsg
  virtual_machine_name       = azurerm_virtual_machine.loc_env_sql02.name
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.71"
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_virtual_machine_extension.loc_env_sql02_customizeOS]

  settings = <<-BASE_SETTINGS
  {
        "modulesUrl": "https://raxazurescripts.blob.core.windows.net/scripts/prep-sqlao.ps1.zip",
        "SasToken": "${var.sas_token}",
        "configurationFunction": "PrepSQLAO.ps1\\PrepSQLAO",
      "properties": {
          "domainName": "${var.ad_domain}",
          "adminCreds": {
          "userName": "${var.ad_username}",
          "password": "PrivateSettingsRef:adminPassword"
        },
          "sqlServiceCreds": {
          "userName": "${var.sql_svc_username}",
          "password": "PrivateSettingsRef:sqlServicePassword"
          },
          "numberOfDisks": "2",
          "workloadType": "GENERAL",
          "databaseEnginePort": "1433",
          "probePortNumber": "59999"
          }
      }
BASE_SETTINGS


  protected_settings = <<-PROTECTED_SETTINGS
  {
    "items": {
    "adminPassword": "${var.ad_password}",
    "sqlServicePassword": "${var.sql_svc_password}"
    }

  }
PROTECTED_SETTINGS

}

resource "azurerm_virtual_machine_extension" "loc_env_sql01_createCluster" {
  name                       = "createCluster"
  location                   = var.location
  resource_group_name        = var.rsg
  virtual_machine_name       = azurerm_virtual_machine.loc_env_sql01.name
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.71"
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_virtual_machine_extension.loc_env_sql02_sqlAOPrepare]

  settings = <<-BASE_SETTINGS
  {
        "modulesUrl": "https://raxazurescripts.blob.core.windows.net/scripts/config-sqlao.ps1.zip",
        "SasToken": "${var.sas_token}",
        "configurationFunction": "ConfigSQLAO.ps1\\ConfigSQLAO",
      "properties": {
          "domainName": "${var.ad_domain}",
          "clusterName": "${var.sql_prefix}-clu",
          "sqlAlwaysOnAvailabilityGroupName": "${var.sql_prefix}-ag",
          "sqlAlwaysOnAvailabilityGroupListenerName": "${var.sql_prefix}-lsnr",
          "sqlAlwaysOnEndpointName": "${var.sql_prefix}-hadr",
          "clusterIpAddresses": "${element(var.sql_ip_addresses, 2)}",
          "agListenerIpAddress": "${element(var.sql_ip_addresses, 3)}",
          "nodes":[
            "${azurerm_virtual_machine.loc_env_sql01.name}",
            "${azurerm_virtual_machine.loc_env_sql02.name}"
          ],
          "primaryReplica": "${azurerm_virtual_machine.loc_env_sql01.name}",
          "secondaryReplica": "${azurerm_virtual_machine.loc_env_sql02.name}",
          "numberOfDisks": "2",
          "workloadType": "GENERAL",
          "databaseEnginePort": "1433",
          "probePortNumber": "59999",
          "witnessStorageName": "${azurerm_storage_account.fswsa.name}",
          "witnessStorageKey": {
          "userName": "PLACEHOLDER-DO-NOT-USE",
          "password": "PrivateSettingsRef:witnessStorageKey"
                        },
          "adminCreds": {
          "userName": "${var.ad_username}",
          "password": "PrivateSettingsRef:adminPassword"
          },
          "sqlServiceCreds": {
          "userName": "${var.sql_svc_username}",
          "password": "PrivateSettingsRef:sqlServicePassword"
          }
          }
      }
BASE_SETTINGS


  protected_settings = <<-PROTECTED_SETTINGS
  {
    "items": {
    "adminPassword": "${var.ad_password}",
    "sqlServicePassword": "${var.sql_svc_password}",
    "witnessStorageKey": "${azurerm_storage_account.fswsa.primary_access_key}"
    }

  }
PROTECTED_SETTINGS

}

