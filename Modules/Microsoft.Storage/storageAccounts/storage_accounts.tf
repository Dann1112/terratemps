#############################
# Diagnostics Storage Account
#############################

 resource "random_id" "randomId" {
   byte_length = 8
 }

 module "storage_account_diagnostics_storage" {
  source      = ".//storage_account"
  sa_rsg      = azurerm_resource_group.rsg_all.name
  sa_name     = "${random_id.randomId.hex}diagsa"
  location    = var.location
  environment = var.environment
  buildby     = var.buildby
}

##################
# Storage Accounts
##################

module "storage_account_data_store" {
  source         = ".//storage_account"
  sa_rsg         = azurerm_resource_group.rsg_dmz.name
  sa_name        = "locenvdatastore01"
  sa_tier        = "Standard"
  sa_kind        = "StorageV2"
  sa_replication = "LRS"
  sa_access_tier = "Hot"
  location       = var.location
  environment    = var.environment
  buildby        = var.buildby
  buildticket    = var.buildticket
}

module "storage_account_file_store" {
  source         = ".//storage_account"
  sa_rsg         = azurerm_resource_group.rsg_dmz.name
  sa_name        = "locenvfilestore01"
  sa_tier        = "Standard"
  sa_kind        = "StorageV2"
  sa_replication = "LRS"
  sa_access_tier = "Hot"
  location       = var.location
  environment    = var.environment
  buildby        = var.buildby
  buildticket    = var.buildticket
}
