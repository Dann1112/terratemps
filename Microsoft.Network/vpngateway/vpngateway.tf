#VPN Gateway
# See https://www.terraform.io/docs/providers/azurerm/r/virtual_network_gateway.html for syntax.

#Public IP for Gateway
resource "azurerm_public_ip" "vpngw_pip" {
  name                         = "${var.vnet_name}-VPNGW-PIP"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.vnet_rsg.name
  allocation_method            = "Dynamic"

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_virtual_network_gateway" "vpngw" {
  name                = "${var.vnet_name}-VPNGW"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpngw_pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.gw.id #Make sure you have a data resource to refernce the subnet
  }
}

resource "azurerm_local_network_gateway" "localgw" {
  name                = "LocalGW"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name
  gateway_address     = var.gateway_address
  address_space       = var.S2S_range
}

resource "azurerm_virtual_network_gateway_connection" "onpremise" {
  name                = "Site-to-Site"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rsg.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpngw.id
  local_network_gateway_id   = azurerm_local_network_gateway.localgw.id

  shared_key = var.vpn_sharedkey
}

