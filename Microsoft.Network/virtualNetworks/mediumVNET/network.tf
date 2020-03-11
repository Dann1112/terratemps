#VNET
# See https://www.terraform.io/docs/providers/azurerm/r/virtual_network.html for syntax.

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name

  subnet {
    name           = var.dmz_subnetA_name
    address_prefix = var.dmz_subnetA_range
    security_group = azurerm_network_security_group.dmznsgA.id
  }

  subnet {
    name           = var.dmz_subnetB_name
    address_prefix = var.dmz_subnetB_range
    security_group = azurerm_network_security_group.dmznsgB.id
  }

  subnet {
    name           = var.app_subnetA_name
    address_prefix = var.app_subnetA_range
    security_group = azurerm_network_security_group.appnsgA.id
  }

  subnet {
    name           = var.app_subnetB_name
    address_prefix = var.app_subnetB_range
    security_group = azurerm_network_security_group.appnsgB.id
  }

  subnet {
    name           = var.ins_subnetA_name
    address_prefix = var.ins_subnetA_range
    security_group = azurerm_network_security_group.insnsgA.id
  }

  subnet {
    name           = var.ins_subnetB_name
    address_prefix = var.ins_subnetB_range
    security_group = azurerm_network_security_group.insnsgB.id
  }

  subnet {
    name           = var.ad_subnetA_name
    address_prefix = var.ad_subnetA_range
    security_group = azurerm_network_security_group.adnsgA.id
  }

  subnet {
    name           = var.ad_subnetB_name
    address_prefix = var.ad_subnetB_range
    security_group = azurerm_network_security_group.adnsgB.id
  }

  subnet {
    name           = var.rbast_subnet_name
    address_prefix = var.rbast_subnet_range
    security_group = azurerm_network_security_group.rbastnsg.id
  }

  subnet {
    name           = var.agw_subnetA_name
    address_prefix = var.agw_subnetA_range
    security_group = azurerm_network_security_group.agwnsgA.id
  }

  subnet {
    name           = var.agw_subnetB_name
    address_prefix = var.agw_subnetB_range
    security_group = azurerm_network_security_group.agwnsgB.id
  }

  subnet {
    name           = var.gw_subnet_name
    address_prefix = var.gw_subnet_range
  }

  tags = {
    Environment = var.environmentA
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

#data sources to be able to reference subnet IDs for NICs
data "azurerm_subnet" "dmzA" {
  name                 = var.dmz_subnetA_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rsg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

data "azurerm_subnet" "dmzB" {
  name                 = var.dmz_subnetB_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rsg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

data "azurerm_subnet" "appA" {
  name                 = var.app_subnetA_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rsg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

data "azurerm_subnet" "appB" {
  name                 = var.app_subnetB_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rsg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

data "azurerm_subnet" "insA" {
  name                 = var.ins_subnetA_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rsg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

data "azurerm_subnet" "insB" {
  name                 = var.ins_subnetB_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rsg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

data "azurerm_subnet" "adA" {
  name                 = var.ad_subnetA_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rsg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

data "azurerm_subnet" "adB" {
  name                 = var.ad_subnetB_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rsg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

data "azurerm_subnet" "agwA" {
  name                 = var.agw_subnetA_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rsg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

data "azurerm_subnet" "agwB" {
  name                 = var.agw_subnetB_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rsg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

data "azurerm_subnet" "rbast" {
  name                 = var.rbast_subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rsg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

data "azurerm_subnet" "gw" {
  name                 = var.gw_subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rsg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

#VNET NSGs
resource "azurerm_network_security_group" "dmznsgA" {
  name                = "${var.dmz_subnetA_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name

  tags = {
    Environment = var.environmentA
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }

  security_rule {
    name                       = "Allow_LOCAL_SUBNET_INBOUND"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.dmz_subnetA_range
    destination_address_prefix = var.dmz_subnetA_range
  }

  security_rule {
    name                       = "Allow_AZURE_LB_INBOUND"
    priority                   = 126
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = var.dmz_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_RDP_INBOUND"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.dmz_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SSH_INBOUND"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.dmz_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_WinRM_INBOUND"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.dmz_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SFTBROKER_INBOUND"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.dmz_subnetA_range
  }

  security_rule {
    name                       = "Allow_Web_to_DMZ_HTTPS_HTTP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["443", "80"]
    source_address_prefix      = "*"
    destination_address_prefix = var.dmz_subnetA_range
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_UDP"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_TCP"
    priority                   = 4001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "dmznsgB" {
  name                = "${var.dmz_subnetB_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name

  tags = {
    Environment = var.environmentB
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }

  security_rule {
    name                       = "Allow_LOCAL_SUBNET_INBOUND"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.dmz_subnetB_range
    destination_address_prefix = var.dmz_subnetB_range
  }

  security_rule {
    name                       = "Allow_AZURE_LB_INBOUND"
    priority                   = 126
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = var.dmz_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_RDP_INBOUND"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.dmz_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SSH_INBOUND"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.dmz_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_WinRM_INBOUND"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.dmz_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SFTBROKER_INBOUND"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.dmz_subnetB_range
  }

  security_rule {
    name                       = "Allow_Web_to_DMZ_HTTPS_HTTP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["443", "80"]
    source_address_prefix      = "*"
    destination_address_prefix = var.dmz_subnetB_range
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_UDP"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_TCP"
    priority                   = 4001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "appnsgA" {
  name                = "${var.app_subnetA_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name

  tags = {
    Environment = var.environmentA
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }

  security_rule {
    name                       = "Allow_LOCAL_SUBNET_INBOUND"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.app_subnetA_range
    destination_address_prefix = var.app_subnetA_range
  }

  security_rule {
    name                       = "Allow_AZURE_LB_INBOUND"
    priority                   = 126
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = var.app_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_RDP_INBOUND"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.app_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SSH_INBOUND"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.app_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_WinRM_INBOUND"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.app_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SFTBROKER_INBOUND"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.app_subnetA_range
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_UDP"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_TCP"
    priority                   = 4001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "appnsgB" {
  name                = "${var.app_subnetB_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name

  tags = {
    Environment = var.environmentB
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }

  security_rule {
    name                       = "Allow_LOCAL_SUBNET_INBOUND"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.app_subnetB_range
    destination_address_prefix = var.app_subnetB_range
  }

  security_rule {
    name                       = "Allow_AZURE_LB_INBOUND"
    priority                   = 126
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = var.app_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_RDP_INBOUND"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.app_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SSH_INBOUND"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.app_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_WinRM_INBOUND"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.app_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SFTBROKER_INBOUND"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.app_subnetB_range
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_UDP"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_TCP"
    priority                   = 4001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "insnsgA" {
  name                = "${var.ins_subnetA_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name

  tags = {
    Environment = var.environmentA
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }

  security_rule {
    name                       = "Allow_LOCAL_SUBNET_INBOUND"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.ins_subnetA_range
    destination_address_prefix = var.ins_subnetA_range
  }

  security_rule {
    name                       = "Allow_AZURE_LB_INBOUND"
    priority                   = 126
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = var.ins_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_RDP_INBOUND"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ins_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SSH_INBOUND"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ins_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_WinRM_INBOUND"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ins_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SFTBROKER_INBOUND"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ins_subnetA_range
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_UDP"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_TCP"
    priority                   = 4001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "insnsgB" {
  name                = "${var.ins_subnetB_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name

  tags = {
    Environment = var.environmentB
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }

  security_rule {
    name                       = "Allow_LOCAL_SUBNET_INBOUND"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.ins_subnetB_range
    destination_address_prefix = var.ins_subnetB_range
  }

  security_rule {
    name                       = "Allow_AZURE_LB_INBOUND"
    priority                   = 126
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = var.ins_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_RDP_INBOUND"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ins_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SSH_INBOUND"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ins_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_WinRM_INBOUND"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ins_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SFTBROKER_INBOUND"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ins_subnetB_range
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_UDP"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_TCP"
    priority                   = 4001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "adnsgA" {
  name                = "${var.ad_subnetA_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name

  tags = {
    Environment = var.environmentA
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }

  security_rule {
    name                       = "Allow_LOCAL_SUBNET_INBOUND"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.ad_subnetA_range
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_AZURE_LB_INBOUND"
    priority                   = 126
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_RDP_INBOUND"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SSH_INBOUND"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_WinRM_INBOUND"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SFTBROKER_INBOUND"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_53"
    priority                   = 131
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "53"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_88"
    priority                   = 132
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "88"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_UDP_123"
    priority                   = 133
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "123"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_TCP_135"
    priority                   = 134
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "135"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_137"
    priority                   = 135
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "137"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_UDP_138"
    priority                   = 136
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "138"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_TCP_139"
    priority                   = 137
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "139"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_389"
    priority                   = 138
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "389"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_445"
    priority                   = 139
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "445"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_464"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "464"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_636"
    priority                   = 141
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "636"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_TCP_3268"
    priority                   = 142
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3268"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_TCP_3269"
    priority                   = 143
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3269"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_TCP_5722"
    priority                   = 144
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5722"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_49152_65535"
    priority                   = 145
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "49152-65535"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_TCP_9389"
    priority                   = 146
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9389"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Allow_WinRM_5985"
    priority                   = 147
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetA_range
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_UDP"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_TCP"
    priority                   = 4001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "adnsgB" {
  name                = "${var.ad_subnetB_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name

  tags = {
    Environment = var.environmentB
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }

  security_rule {
    name                       = "Allow_LOCAL_SUBNET_INBOUND"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.ad_subnetB_range
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_AZURE_LB_INBOUND"
    priority                   = 126
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_RDP_INBOUND"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SSH_INBOUND"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_WinRM_INBOUND"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_RACK_BASTION_SFTBROKER_INBOUND"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_53"
    priority                   = 131
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "53"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_88"
    priority                   = 132
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "88"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_UDP_123"
    priority                   = 133
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "123"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_TCP_135"
    priority                   = 134
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "135"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_137"
    priority                   = 135
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "137"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_UDP_138"
    priority                   = 136
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "138"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_TCP_139"
    priority                   = 137
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "139"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_389"
    priority                   = 138
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "389"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_445"
    priority                   = 139
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "445"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_464"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "464"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_636"
    priority                   = 141
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "636"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_TCP_3268"
    priority                   = 142
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3268"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_TCP_3269"
    priority                   = 143
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3269"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_TCP_5722"
    priority                   = 144
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5722"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_TCP_UDP_49152_65535"
    priority                   = 145
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "49152-65535"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_TCP_9389"
    priority                   = 146
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9389"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Allow_WinRM_5985"
    priority                   = 147
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = var.ad_subnetB_range
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_UDP"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_TCP"
    priority                   = 4001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "rbastnsg" {
  name                = "${var.rbast_subnet_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name

  tags = {
    Environment = var.environmentA
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }

  security_rule {
    name                       = "Allow_LOCAL_SUBNET_INBOUND"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.rbast_subnet_range
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SSH_PDFW"
    priority                   = 126
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "72.3.186.100/32"
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SSH_PIAD"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "146.20.30.100/32"
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SSH_PORD"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "161.47.6.100/32"
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SSH_PHKG"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "120.136.39.100/32"
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SSH_PLON"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "134.213.183.100/32"
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SSH_PLON5"
    priority                   = 131
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "134.213.182.100/32"
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SSH_PSYD"
    priority                   = 132
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "119.9.163.100/32"
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SFTBROKER_PDFW"
    priority                   = 133
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = "72.3.186.100/32"
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SFTBROKER_PIAD"
    priority                   = 134
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = "146.20.30.100/32"
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SFTBROKER_PORD"
    priority                   = 135
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = "161.47.6.100/32"
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SFTBROKER_PHKG"
    priority                   = 136
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = "120.136.39.100/32"
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SFTBROKER_PLON"
    priority                   = 137
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = "134.213.183.100/32"
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SFTBROKER_PLON5"
    priority                   = 138
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = "134.213.182.100/32"
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Allow_RAX_SFTBROKER_PSYD"
    priority                   = 139
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4421"
    source_address_prefix      = "119.9.163.100/32"
    destination_address_prefix = var.rbast_subnet_range
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_UDP"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_TCP"
    priority                   = 4001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "agwnsgA" {
  name                = "${var.agw_subnetA_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name

  security_rule {
    name                       = "Allow_LOCAL_SUBNET_INBOUND"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.agw_subnetA_range
    destination_address_prefix = var.agw_subnetA_range
  }

  security_rule {
    name                       = "Allow_AZURE_LB_INBOUND"
    priority                   = 126
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = var.agw_subnetA_range
  }

  security_rule {
    name                       = "Allow_ApplicationGateway_Health_Ports_INBOUND"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "*"
    destination_address_prefix = var.agw_subnetA_range
  }

  security_rule {
    name                       = "Allow_HTTP_INBOUND"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = var.agw_subnetA_range
  }

  security_rule {
    name                       = "Allow_HTTPS_INBOUND"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = var.agw_subnetA_range
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_UDP"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_TCP"
    priority                   = 4001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Environment = var.environmentA
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_network_security_group" "agwnsgB" {
  name                = "${var.agw_subnetB_name}-NSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name

  security_rule {
    name                       = "Allow_LOCAL_SUBNET_INBOUND"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.agw_subnetB_range
    destination_address_prefix = var.agw_subnetB_range
  }

  security_rule {
    name                       = "Allow_AZURE_LB_INBOUND"
    priority                   = 126
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = var.agw_subnetB_range
  }

  security_rule {
    name                       = "Allow_ApplicationGateway_Health_Ports_INBOUND"
    priority                   = 127
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "*"
    destination_address_prefix = var.agw_subnetB_range
  }

  security_rule {
    name                       = "Allow_HTTP_INBOUND"
    priority                   = 128
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = var.agw_subnetB_range
  }

  security_rule {
    name                       = "Allow_HTTPS_INBOUND"
    priority                   = 129
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = var.agw_subnetB_range
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_UDP"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny_ALL_INBOUND_TCP"
    priority                   = 4001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Environment = var.environmentB
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

