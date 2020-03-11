/* Configure Azure Provider and declare all the Variables that will be used in Terraform configurations */
provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

variable "subscription_id" {
  description = "Enter Subscription ID for provisioning resources in Azure"
}

variable "client_id" {
  description = "Enter Client ID for Application created in Azure AD"
}

variable "client_secret" {
  description = "Enter Client secret for Application in Azure AD"
}

variable "tenant_id" {
  description = "Enter Tenant ID / Directory ID of your Azure AD. Run Get-AzureSubscription to know your Tenant ID"
}

variable "buildby" {
  description = "Name of the builder."
  default     = ""
}

variable "buildticket" {
  description = "Ticket Number for the build"
  default     = ""
}

variable "environment" {
  description = "PRD,QA,STG,DEV,etc."
  default     = "PRD"
}

variable "location" {
  description = "Azure region the environment."
  default     = "East US 2"
}

####################
# CDN Details
####################
variable "cdn_rsg" {
  description = "Name of the Resource Group which the CDN profile should reside in."
  default     = "LOC-RSG-NET-ENV"
}

variable "cdn_name" {
  description = "Name of the CDN profile to create."
  default     = "LOC-ENV-CDN01"
}

variable "cdn_location" {
  description = "The location that the CDN metadata profile should reside in. Available regions are: Australia East, Australia Southeast, Brazil South, Canada Central, Canada East, Central India, Central US, East Asia, East US, East US 2, Japan East, Japan West, North Central US, North Europe, South Central US, South India, Soundeast Asia, West Europe, West India, West US, West Central US."
  default     = "West US"
}

variable "cdn_sku" {
  description = "The provider of the CDN service. Either Standard_Akamai, STandard_Microsoft, Standard_Verizon, Premium_Verizon, or Standard_ChinaCdn."
  default     = "Standard_Verizon"
}

# variable "cdn_endpoint_name" {
#   description = "Name of the CDN endpoint to create."
#   default = ""
# }
