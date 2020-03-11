# Code for Resource Groups begins here.
# See https://www.terraform.io/docs/providers/azurerm/r/resource_group.html for syntax

resource "azurerm_resource_group" "vnet_rsg" {
  name     = var.vnet_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "dmz_rsg" {
  name     = var.dmz_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "ad_rsg" {
  name     = var.ad_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "app_rsg" {
  name     = var.app_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "paas_rsg" {
  name     = var.paas_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "mgmt_rsg" {
  name     = var.mgmt_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "rbast_rsg" {
  name     = var.rbast_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

