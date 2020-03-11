resource "azurerm_resource_group" "bastion" {
  name     = "${var.zones_map[var.location]}-RSG-RAX-SFT"
  location = var.location
}

