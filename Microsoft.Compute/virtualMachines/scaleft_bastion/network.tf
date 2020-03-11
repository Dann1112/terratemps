data "azurerm_subnet" "bastion" {
  name                 = var.vnet_rbast_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rsg
}

