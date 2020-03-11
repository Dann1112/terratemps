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
  default     = ""
}

############
# VM Details
############

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

variable "vm_size" {
  description = "Size of the VM you want to create"
  default     = ""
}

variable "admin_password" {
  description = "password for all VMs"
}

variable "vm_name" {
  description = "name for the VM"
  default     = ""
}

variable "vm_avset" {
  description = "Name of the Availability Set to create"
  default     = "LOC-ENV-VM-AS"
}

variable "vm_disk_sku" {
  description = "Type of disk to use. Either Standard_LRS or Premium_LRS."
  default     = "Standard_LRS"
}

variable "vm_timezone" {
  description = "Timezone to set the OS to using Microsoft Tiemzone Index values. See https://support.microsoft.com/en-gb/help/973627/microsoft-time-zone-index-values for values (2nd column)."
  default     = "UTC"
}

############
# Extension Details. Remove if necessary.
############

variable "storage_account" {
  description = "Asset storage account"
  default     = "raxazurescripts"
}

variable "storage_account_key" {
  description = "Storage Account Key for asset storage account. Can be found at https://passwordsafe.corp.rackspace.com/projects/25979/credentials"
}

variable "workspace_id" {
  description = "Workspace ID of OMS workspace the VM should join"
  default     = ""
}

variable "workspace_key" {
  description = "The key of the OMS workspace the VM should join"
  default     = ""
}

variable "vm_extension_ad_domain" {
  description = "AD Domain to join."
  default     = "rackspace.local"
}

variable "vm_extension_ad_ou" {
  description = "Default Organizational Unit path for computers."
  default     = ""
}

variable "vm_extension_ad_username" {
  description = "Domain Adminsitrator username."
  default     = "user-adm"
}

variable "vm_extension_ad_password" {
  description = "Domain Administrator password."
}

