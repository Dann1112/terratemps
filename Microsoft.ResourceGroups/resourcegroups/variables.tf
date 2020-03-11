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
  description = "Azure region for the environment."
  default     = "East US 2"
}

variable "vnet_rsg_name" {
  description = "Name of the VNET azure resource group."
  default     = "EU2-PRD-VNET"
}

variable "dmz_rsg_name" {
  description = "Name of the dmz azure resource group."
  default     = "EU2-PRD-DMZ"
}

variable "ad_rsg_name" {
  description = "Name of the ad azure resource group."
  default     = "EU2-PRD-AD"
}

variable "app_rsg_name" {
  description = "Name of the app azure resource group."
  default     = "EU2-PRD-APP"
}

variable "paas_rsg_name" {
  description = "Name of the PaaS azure resource group."
  default     = "EU2-PRD-PAAS"
}

variable "mgmt_rsg_name" {
  description = "Name of the MGMT azure resource group."
  default     = "EU2-PRD-MGMT"
}

variable "rbast_rsg_name" {
  description = "Name of the bastion azure resource group."
  default     = "EU2-RSG-RAX-SFT"
}

