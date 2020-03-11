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
  default     = ""
}

variable "rsg" {
  description = "Name of the Resource Group The VM will be built"
  default     = ""
}

variable "vnet" {
  description = "Name of the VNET you want to deploy the VM to"
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

variable "sql1_vm_name" {
  description = "Name for the first SQL VMs."
  default     = "LOC-ENV-SQL01"
}

variable "sql2_vm_name" {
  description = "Name for the first SQL VMs."
  default     = "LOC-ENV-SQL02"
}

variable "sql_prefix" {
  description = "Name for the SQL Prefix (LOC-ENV-SQL)."
  default     = "LOC-ENV-SQL"
}

variable "sql_vm_size" {
  description = "Size of the SQL VMs to be created."
  default     = "Standard_D2s_v3"
}

variable "sql_avset_name" {
  description = "Name for the Availability Set."
  default     = "LOC-ENV-SQL-AVSET"
}

variable "sql_ip_addresses" {
  description = "Static IPs to assign to the SQL Servers and resources(4 required)."
  type        = list(string)
  default     = ["172.16.194.4", "172.16.194.5", "172.16.194.98", "172.16.194.99"]
}

variable "data_disk_size" {
  description = "Size of the SQL data disk."
  default     = 128
}

variable "data_disk_sku" {
  description = "Standard_LRS or Premium_LRS."
  default     = "Premium_LRS"
}

variable "log_disk_size" {
  description = "Size of the SQL data disk."
  default     = 128
}

variable "log_disk_sku" {
  description = "Standard_LRS or Premium_LRS."
  default     = "Premium_LRS"
}

variable "sql_timezone" {
  description = "Timezone to set the VMs to."
  default     = "Eastern Standard Time"
}

variable "ad_domain" {
  description = "Active Directory domain to join."
  default     = "rackspace.local"
}

variable "ad_username" {
  description = "Name of Domain Admin account for domain join."
  default     = "rax_admin"
}

variable "ad_password" {
  description = "Domain Admin password for domain join."
}

variable "sql_svc_username" {
  description = "Name of SQL Sevice account."
  default     = "sql_svc"
}

variable "sql_svc_password" {
  description = "Password for SQL Sevice account."
}

variable "sas_token" {
  description = "SAS token for asset storage account. Can be found at https://passwordsafe.corp.rackspace.com/projects/25979/credentials"
}

variable "storage_account" {
  description = "Asset storage account"
  default     = "raxazurescripts"
}

variable "storage_account_key" {
  description = "Storage Account Key for asset storage account. Can be found at https://passwordsafe.corp.rackspace.com/projects/25979/credentials"
}

