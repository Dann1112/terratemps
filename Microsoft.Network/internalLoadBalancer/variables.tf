/* Configure Azure Provider and declare all the Variables that will be used in Terraform configurations */
provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

#Variables for entire enviroment.
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
  default     = ""
}

variable "rsg_name" {
  description = "The name of the resource group the load balancer will be created in"
  default     = ""
}

variable "lb_name" {
  description = "The name of the load balancer"
  default     = ""
}

variable "lb_sku" {
  description = "The SKU of the Azure Load Balancer. Accepted values are Basic and Standard."
  default     = "Basic"
}

variable "vnet" {
  description = "Name of the VNET you want to deploy the load balancer to"
  default     = ""
}

variable "subnet" {
  description = "Name of the subnet you want to deploy the load balancer to"
  default     = ""
}

variable "subnet_rsg" {
  description = "Name of the Resource Group the VNET is located in"
  default     = ""
}

