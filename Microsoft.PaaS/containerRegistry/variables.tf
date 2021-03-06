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
  default     = "Racker Name"
}

variable "buildticket" {
  description = "Ticket Number for the build"
  default     = ""
}

variable "environment" {
  description = "Prod,QA,STG,DEV,etc."
  default     = "Production"
}

variable "location" {
  description = "Azure region the environment."
  default     = "UK South"
}

#####################
# ACR Details
#####################
variable "acr_resource_group_name" {
  description = "Name of the Resource Group to contain the ACR"
  default     = "LOC-ENV-ACR"
}

variable "acr_name" {
  description = "Name of the Azure Container Registry to be created"
  default     = "locenvacr"
}

variable "acr_sku" {
  description = "SKU tier for the service"
  default     = "Standard"
}

