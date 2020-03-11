# https://www.terraform.io/docs/providers/azurerm/r/cdn_profile.html#

resource "azurerm_cdn_profile" "cdn_profile" {
  name                = var.cdn_name
  location            = var.cdn_location
  resource_group_name = var.cdn_rsg
  sku                 = var.cdn_sku

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

##########################################
# Example endpoint that uses the FQDN assigned to a Public IP
##########################################
# resource "azurerm_cdn_endpoint" "cdn_endpoint_pip" {
#   name                = "${var.cdn_endpoint_name}"
#   resource_group_name = "${var.cdn_rsg}"
#   location            = "${azurerm_cdn_profile.cdn_profile.location}"
#   profile_name        = "${azurerm_cdn_profile.cdn_profile.name}"
#   is_compression_enabled    = true
#   content_types_to_compress = ["text/plain", "text/html", "text/css", "text/javascript", "application/x-javascript", "application/javascript", "application/json", "application/xml"]
#   origin {
#     name      = "${var.cdn_endpoint_name}"
#     host_name = "${azurerm_public_ip.pip.fqdn}"
#   }
# }
##########################################
# Example endpoint that points to a Storage Account
##########################################
# resource "azurerm_cdn_endpoint" "cdn_endpoint_storage" {
#   name                = "${var.cdn_endpoint_name}"
#   resource_group_name = "${var.cdn_rsg}"
#   location            = "${azurerm_cdn_profile.cdn_profile.location}"
#   profile_name        = "${azurerm_cdn_profile.cdn_profile.name}"
#   is_compression_enabled    = true
#   content_types_to_compress = ["text/plain", "text/html", "text/css", "text/javascript", "application/x-javascript", "application/javascript", "application/json", "application/xml"]
#   origin {
#     name      = "${var.cdn_endpoint_name}"
#     host_name = "${azurerm_storage_account.storage.name}.blob.core.windows.net"
#   }
# }
