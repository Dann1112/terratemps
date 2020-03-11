#See https://www.terraform.io/docs/providers/azurerm/r/application_gateway.html for syntax

#####################
# Public IP
#####################
resource "azurerm_public_ip" "agw_pip" {
  name                = "${var.agw_name}-pip"
  location            = var.location
  resource_group_name = var.agw_rsg
  allocation_method   = var.public_ip_allocation
  sku                 = var.public_ip_sku

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

#####################
# Application Gateway
#####################
resource "azurerm_application_gateway" "agw" {
  name                = var.agw_name
  resource_group_name = var.agw_rsg
  location            = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }

  sku {
    name     = var.agw_size
    tier     = var.agw_tier
    capacity = var.agw_capacity
  }

  gateway_ip_configuration {
    name      = "${var.agw_name}-ipconf"
    subnet_id = data.azurerm_subnet.agw_subnet.id
  }

  frontend_port {
    name = local.frontend_port_name_80
    port = 80
  }

  frontend_port {
    name = local.frontend_port_name_443
    port = 443
  }

  frontend_ip_configuration {
    name                 = "appGatewayFrontendIp"
    public_ip_address_id = azurerm_public_ip.agw_pip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = var.agw_cookie_affinity
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  ssl_certificate {
    name     = local.ssl_certificate_name
    data     = local.ssl_certificate_data
    password = local.ssl_certificate_pass
  }

  /*
          waf_configuration {
            enabled          = "${var.agw_waf_enable}"
            firewall_mode    = "${var.agw_waf_mode}"
            rule_set_type    = "OWASP"
            rule_set_version = "3.0"
          }
        */
  http_listener {
    name                           = local.listener_name_80
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = local.frontend_port_name_80
    protocol                       = "Http"
  }

  http_listener {
    name                           = local.listener_name_443
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = local.frontend_port_name_443
    protocol                       = "Https"
    require_sni                    = false
    ssl_certificate_name           = local.ssl_certificate_name
  }

  request_routing_rule {
    name                       = "Default-HTTP-Rule"
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name_80
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  request_routing_rule {
    name                       = "Default-HTTPS-Rule"
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name_443
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}

data "azurerm_subnet" "agw_subnet" {
  name                 = var.agw_vnet_subnet_name
  virtual_network_name = var.agw_vnet_name
  resource_group_name  = var.agw_vnet_rsg
}

locals {
  backend_address_pool_name = "appGatewayBackendPool"
  frontend_port_name_80     = "FE-Port-80"
  frontend_port_name_443    = "FE-Port-443"
  http_setting_name         = "BE-HTTP-80"
  listener_name_80          = "Default-HTTP-Listener"
  listener_name_443         = "Default-HTTPS-Listener"
  ssl_certificate_name      = var.agw_ssl_name
  ssl_certificate_data      = var.agw_ssl_data
  ssl_certificate_pass      = var.agw_ssl_password
}

