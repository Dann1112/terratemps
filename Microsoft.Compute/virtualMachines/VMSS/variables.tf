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

variable "coreDevice" {
  description = "Customer's Core Device"
  default     = ""
}

variable "location" {
  description = "Azure region for the environment."
  default     = ""
}

variable "rsg" {
  description = "Name of the Resource Group The VM will be built"
  default     = ""
}

variable "vnet" {
  description = "Name of the VNEt you want to deploy the VM to"
  default     = ""
}

variable "subnet" {
  description = "Name of the subnet you want to deploy the VM to"
  default     = ""
}

variable "subnet_rsg" {
  description = "Name of the Resource Group the VNET is located in"
  default     = ""
}

variable "admin_password" {
  description = "password for all VMs"
  default     = ""
}

variable "vmss_name" {
  description = "name for the scale set"
  default     = ""
}

variable "vm_name" {
  description = "name for VMs in scale set"
  default     = ""
}

variable "dns_lablel" {
  description = "DNS name for VMSS load balancer"
  default     = ""
}

