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
  description = "Prod,QA,STG,DEV,etc."
  default     = ""
}

variable "location" {
  description = "Azure region the environment."
  default     = "East US 2"
}

variable "vnet_name" {
  description = "name for the vnet."
  default     = ""
}

variable "vpn_sharedkey" {
  description = "24 digit random key"
  default     = ""
}

variable "S2S_range" {
  description = "Private IP range of customer's on-prem enviroment"
  default     = ["192.168.1.0/24"]
}

variable "gateway_address" {
  description = "Public IP address of customer's firewall device"
  default     = "1.1.1.1"
}

