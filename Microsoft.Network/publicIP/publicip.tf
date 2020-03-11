# See https://www.terraform.io/docs/providers/azurerm/r/public_ip.html for syntax.

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.vm_name}-pip"
  location            = var.location
  resource_group_name = var.rsg_name
  allocation_method   = "Static"
  sku                 = var.lb_sku
}


