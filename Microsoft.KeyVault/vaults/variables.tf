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
  description = "View environment_map listeing below for valid values"
  default     = "Production"
}

variable "location" {
  description = "Azure region the environment."
  default     = "West US 2"
}

#####################
# Key Vault Details
#####################
variable "kv_rsg" {
  description = "Resource Group where the Key Vault will reside in."
  default     = "LOC-RSG-NET-ENV"
}

variable "kv_name" {
  description = "Name of the Key Vault to be built"
  default     = "LOC-ENV-KVLT01"
}

variable "kv_sku" {
  description = "SKU of the Key Vault. Either standard or premium (case sensitive)."
  default     = "standard"
}

variable "kv_backup_id" {
  description = "Object ID of the Backup Management Service service principal to allow backups of encrypted disks. az ad sp list --display-name 'Backup Management Service' -o json"
  default     = ""
}

