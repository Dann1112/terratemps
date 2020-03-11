#####################
# Resource Group
#####################

resource "azurerm_resource_group" "rsg" {
  name     = "${var.zones_map[var.location]}${var.environment_map[var.environment]}a-csr-rg0${var.csr_count + 1}"
  location = var.zones_name_map[var.location]

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

#####################
# VNET
#####################

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.zones_map[var.location]}${var.environment_map[var.environment]}a-csr-vnet0${var.csr_count + 1}"
  address_space       = var.vnet_address_space
  location            = var.zones_name_map[var.location]
  resource_group_name = azurerm_resource_group.rsg.name

  subnet {
    name           = "subnet1"
    address_prefix = var.first_subnet_range
    security_group = azurerm_network_security_group.csrnsg.id
  }

  subnet {
    name           = "subnet2"
    address_prefix = var.second_subnet_range
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

#data sources to be able to reference subnet IDs for NICs
data "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rsg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

data "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rsg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

#VNET NSGs
resource "azurerm_network_security_group" "csrnsg" {
  name                = "${var.zones_map[var.location]}${var.environment_map[var.environment]}a-csr-1000v-0${var.csr_count + 1}-nsg"
  location            = var.zones_name_map[var.location]
  resource_group_name = azurerm_resource_group.rsg.name

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }

  security_rule {
    name                       = "SSH-Rule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "UDP-Rule1"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = 500
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "UDP-Rule2"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = 4500
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SNMP"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = 161
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "TFTP"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = 69
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#####################
# Route Tables
#####################

resource "azurerm_route_table" "subnet1_route_table" {
  name                = "subnet1-CSR-RouteTable"
  resource_group_name = azurerm_resource_group.rsg.name
  location            = var.zones_name_map[var.location]

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_route_table" "subnet2_route_table" {
  name                = "subnet2-CSR-RouteTable"
  resource_group_name = azurerm_resource_group.rsg.name
  location            = var.zones_name_map[var.location]

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_route_table" "routetable_int1" {
  name                = "${var.zones_map[var.location]}${var.environment_map[var.environment]}a-csr-1000v-routetable-int1"
  resource_group_name = azurerm_resource_group.rsg.name
  location            = var.zones_name_map[var.location]

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

#####################
# storage account for boot diag
#####################

resource "random_id" "randomId" {
  byte_length = 4
}

resource "azurerm_storage_account" "vmdiagsa" {
  name                     = "${random_id.randomId.hex}${var.zones_map[var.location]}diagsa"
  resource_group_name      = azurerm_resource_group.rsg.name
  location                 = var.zones_name_map[var.location]
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

#####################
# Public IP
#####################

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.zones_map[var.location]}${var.environment_map[var.environment]}a-csr-1000v-0${var.csr_count + 1}-pip"
  location            = var.zones_name_map[var.location]
  resource_group_name = azurerm_resource_group.rsg.name
  allocation_method   = "Static"
  sku                 = "Basic"

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

#####################
# first nic
#####################

resource "azurerm_network_interface" "loc_env_vm_nic01" {
  name                 = "${var.zones_map[var.location]}${var.environment_map[var.environment]}a-csr-1000v-0${var.csr_count + 1}-nic01"
  location             = var.zones_name_map[var.location]
  resource_group_name  = azurerm_resource_group.rsg.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.subnet1.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

#####################
# second nic
#####################

resource "azurerm_network_interface" "loc_env_vm_nic02" {
  name                 = "${var.zones_map[var.location]}${var.environment_map[var.environment]}a-csr-1000v-0${var.csr_count + 1}-nic02"
  location             = var.zones_name_map[var.location]
  resource_group_name  = azurerm_resource_group.rsg.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.subnet2.id
    private_ip_address_allocation = "dynamic"
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

#####################
# VM
#####################

resource "azurerm_virtual_machine" "loc_env_vm" {
  name                         = "${var.zones_map[var.location]}${var.environment_map[var.environment]}a-csr-1000v-0${var.csr_count + 1}"
  location                     = var.zones_name_map[var.location]
  resource_group_name          = azurerm_resource_group.rsg.name
  primary_network_interface_id = azurerm_network_interface.loc_env_vm_nic01.id
  network_interface_ids        = [azurerm_network_interface.loc_env_vm_nic01.id, azurerm_network_interface.loc_env_vm_nic02.id]
  vm_size                      = var.vm_size

  # Uncomment the line below to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment the line below to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "cisco"
    offer     = "cisco-csr-1000v"
    sku       = "16_9-byol"
    version   = "16.9.220181121"
  }

  plan {
    name      = "16_9-byol"
    publisher = "cisco"
    product   = "cisco-csr-1000v"
  }

  storage_os_disk {
    name              = "${var.zones_map[var.location]}${var.environment_map[var.environment]}a-csr-1000v-0${var.csr_count + 1}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "${var.zones_map[var.location]}${var.environment_map[var.environment]}a-csr-1000v-0${var.csr_count + 1}"
    admin_username = "${var.zones_map[var.location]}${var.environment_map[var.environment]}a-csr-1000v-0${var.csr_count + 1}-adm"
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.vmdiagsa.primary_blob_endpoint
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

