# Data source for the subnet that already exists. If you don't already have a VNET, Add code for VNET.
data "azurerm_subnet" "loc_env_vm_subnet" {
  name                 = var.subnet
  virtual_network_name = var.vnet
  resource_group_name  = var.subnet_rsg
}

resource "azurerm_public_ip" "loc_env_lb_pip" {
  name                         = "${var.vmss_name}-LB-PIP"
  location                     = var.location
  resource_group_name          = var.rsg
  public_ip_address_allocation = "static"
  domain_name_label            = var.dns_lablel

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_lb" "loc_env_lb" {
  name                = "${var.vmss_name}-LB"
  location            = var.location
  resource_group_name = var.rsg

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.loc_env_lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  resource_group_name = var.rsg
  loadbalancer_id     = azurerm_lb.loc_env_lb.id
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_nat_pool" "lbnatpool" {
  count                          = 3
  resource_group_name            = var.rsg
  name                           = "ssh"
  loadbalancer_id                = azurerm_lb.loc_env_lb.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_probe" "lbhealth" {
  resource_group_name = var.rsg
  loadbalancer_id     = azurerm_lb.loc_env_lb.id
  name                = "http-probe"
  protocol            = "tcp"
  port                = 80
}

resource "azurerm_lb_rule" "lbbackendrule" {
  name                           = "load-balancer-rule"
  resource_group_name            = var.rsg
  loadbalancer_id                = azurerm_lb.loc_env_lb.id
  protocol                       = "Tcp"
  frontend_port                  = "80"
  backend_port                   = "80"
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.lbhealth.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.bpepool.id
}

resource "azurerm_virtual_machine_scale_set" "loc_env_vmss" {
  name                = var.vmss_name
  location            = var.location
  resource_group_name = var.rsg

  # automatic rolling upgrade
  automatic_os_upgrade = true
  upgrade_policy_mode  = "Automatic"

  health_probe_id = azurerm_lb_probe.lbhealth.id

  sku {
    name     = "Standard_F2"
    tier     = "Standard"
    capacity = 2
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = 50
  }

  os_profile {
    computer_name_prefix = var.vm_name
    admin_username       = "${lower(var.vm_name)}-adm"
    admin_password       = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  network_profile {
    name    = "terraformnetworkprofile"
    primary = true

    ip_configuration {
      name                                   = "IPConfiguration"
      primary                                = true
      subnet_id                              = data.azurerm_subnet.loc_env_vm_subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
      load_balancer_inbound_nat_rules_ids    = [element(azurerm_lb_nat_pool.lbnatpool.*.id, count.index)]
    }
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

