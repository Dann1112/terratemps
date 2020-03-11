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
  default     = "EU2-VNET01"
}

variable "vnet_address_space" {
  description = "address range for vnet."
  default     = ["172.16.192.0/22"]
}

variable "dmz_subnet_name" {
  description = "Name of the dmz subnet"
  default     = "EU2-VNET01-DMZ"
}

variable "dmz_subnet_range" {
  description = "IP range for dmz subnet"
  default     = "172.16.192.0/24"
}

variable "app_subnet_name" {
  description = "Name of the app subnet"
  default     = "EU2-VNET01-APP"
}

variable "app_subnet_range" {
  description = "IP range for app subnet"
  default     = "172.16.193.0/24"
}

variable "ins_subnet_name" {
  description = "Name of the inside subnet"
  default     = "EU2-VNET01-INS"
}

variable "ins_subnet_range" {
  description = "IP range for app subnet"
  default     = "172.16.194.0/24"
}

variable "ad_subnet_name" {
  description = "Name of the ad subnet"
  default     = "EU2-VNET01-AD"
}

variable "ad_subnet_range" {
  description = "IP range for ad subnet"
  default     = "172.16.195.0/28"
}

variable "rbast_subnet_name" {
  description = "Name of the bastion subnet"
  default     = "EU2-VNET01-RBAST01"
}

variable "rbast_subnet_range" {
  description = "IP range for bastion subnet"
  default     = "172.16.195.16/28"
}

variable "agw_subnet_name" {
  description = "Name of the app gateway subnet"
  default     = "EU2-VNET01-AGW"
}

variable "agw_subnet_range" {
  description = "IP range for app gateway subnet"
  default     = "172.16.195.32/28"
}

variable "gw_subnet_name" {
  description = "Name of the gateway subnet"
  default     = "GatewaySubnet"
}

variable "gw_subnet_range" {
  description = "IP range for gateway subnet"
  default     = "172.16.195.224/27"
}

