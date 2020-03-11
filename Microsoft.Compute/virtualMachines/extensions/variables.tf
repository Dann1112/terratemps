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
  description = "Ticket Number of the build."
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
# All extension plans assume the use of the multivm plan (vm count)
# Modify and state individual virtual_machine_name if dealing with a single VM
############

variable "sas_token" {
  description = "SAS token for asset storage account. Can be found at https://one.rackspace.com/display/FSFA/Support+Enrollment+-+Greenfield+Subscription."
}

variable "storage_account" {
  description = "Asset storage account"
  default     = "raxazurescripts"
}

variable "storage_account_key" {
  description = "Storage Account Key for asset storage account. Can be found at https://passwordsafe.corp.rackspace.com/projects/25979/credentials"
}

variable "admin_password" {
  description = "password for all VMs"
}

variable "vm_name" {
  description = "name for the VMs"
  default     = ""
}

variable "vm_count" {
  description = "number of VMs to create"
  default     = 3
}

variable "vm_timezone" {
  description = "Timezone to set the OS to using Microsoft Tiemzone Index values. See https://support.microsoft.com/en-gb/help/973627/microsoft-time-zone-index-values for values (2nd column)."
  default     = "UTC"
}

########################
# VM Extension Variables
########################

variable "vm_extension_windows_system_locale" {
  description = "Set Windows system locale."
  default     = "en_US"
}

variable "vm_extension_windows_iis" {
  description = "Should IIS be installed? Either Yes or No. Windows Only."
  default     = "Yes"
}

variable "vm_extension_windows_datadisks" {
  description = "Number of data disks presented to the server."
  default     = "2"
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

variable "vm_extension_anyos_apply_updates" {
  description = "Apply updates to OS. Either Yes or No."
  default     = "No"
}

#################
# Mappings
# Do not modify
#################

variable "iis_install_map" {
  type = map(string)

  default = {
    "Yes" = "ConfigDataWeb"
    "No"  = "ConfigDataWindows"
  }
}

