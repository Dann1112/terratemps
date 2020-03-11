# Data source for the subnet that already exists
data "azurerm_subnet" "loc_env_vm_subnet" {
  name                 = var.subnet
  virtual_network_name = var.vnet
  resource_group_name  = var.subnet_rsg
}

resource "azurerm_lb" "prod_lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rsg_name
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name      = "${var.lb_name}-FE"
    subnet_id = data.azurerm_subnet.loc_env_vm_subnet.id
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_lb_backend_address_pool" "prod_lb_backend_pool" {
  resource_group_name = var.rsg_name
  loadbalancer_id     = azurerm_lb.prod_lb.id
  name                = "${var.lb_name}-BEP"
}

resource "azurerm_lb_probe" "prod_lb_probe" {
  resource_group_name = var.rsg_name
  loadbalancer_id     = azurerm_lb.prod_lb.id
  name                = "${var.lb_name}-PRB"
  port                = 1433
}

resource "azurerm_lb_rule" "prod_lb_rule" {
  resource_group_name            = var.rsg_name
  loadbalancer_id                = azurerm_lb.prod_lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 1433
  backend_port                   = 1433
  frontend_ip_configuration_name = "${var.lb_name}-FE"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.prod_lb_backend_pool.id
  probe_id                       = azurerm_lb_probe.prod_lb_probe.id
  load_distribution              = "Default"
}

