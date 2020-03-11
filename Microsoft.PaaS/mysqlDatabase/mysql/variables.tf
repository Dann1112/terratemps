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
  description = "View environment_map listeing below for valid defaults"
  default     = "Production"
}

variable "location" {
  description = "Azure region the environment."
  default     = "West US 2"
}

###############
# MySQL Details
###############
variable "mysql_rsg" {
  description = "Name of the Resource Group the MySQL server should reside in."
  default     = "LOC-RSG-DBS-ENV"
}

variable "mysql_username" {
  description = "Administrator username for the MySQL server."
  default     = "username"
}

variable "mysql_password" {
  description = "Password for the administrator user."
  default     = "password"
}

variable "mysql_server_name" {
  description = "Name of the MySQL server"
  default     = "loc-env-mysql"
}

variable "mysql_version" {
  description = "Version of MySQL to deploy. Either 5.6 or 5.7."
  default     = "5.7"
}

variable "mysql_ssl_enforcement" {
  description = "Whether connections to the MySQL server should be enforced with SSL only. Either Enabled or Disabled."
  default     = "Disabled"
}

variable "mysql_server_sku" {
  description = "SKU for the MySQL server"
  default     = "GP_Gen5_4"
}

variable "mysql_server_tier" {
  description = "Tier of the SKU for the MysQL server. Either Basic, GeneralPurpose, or MemoryOptimized."
  default     = "GeneralPurpose"
}

variable "mysql_server_family" {
  description = "Family of hardware for the MySQL server. Either Gen4 or Gen5."
  default     = "Gen5"
}

variable "msyql_server_capcity" {
  description = "vCore value of the MySQL server"
  default     = 4
}

variable "mysql_storage_size" {
  description = "Storage size of the MySQL server in MiB"
  default     = 102400
}

variable "mysql_backup_retention" {
  description = "Backup retention for the MySQL databases between 7 and 35 days."
  default     = 7
}

variable "mysql_backup_redundancy" {
  description = "Backup geo-redundancy option for the MySQL databases. Either Enabled or Disabled."
  default     = "Disabled"
}

#################################
# MySQL Serivice Endpoint Details
#################################
variable "mysql_vnet_rule_name" {
  description = "Name of the rule when associating with an existing Virtual Network."
  default     = "vnet-connection"
}

variable "vnet_rsg" {
  description = "Resource group that the existing Virutal Network resides in."
  default     = "LOC-RSG-NET-ENV"
}

variable "vnet_name" {
  description = "Name of the exisitng Virtual Network."
  default     = "LOC-VNET01"
}

variable "vnet_subnet" {
  description = "Name of the existing subnet to associate with. NOTE: Ensure the subnet has service endpoint enabled for Microslft.Sql."
  default     = "LOC-VNET01-APP-ENV"
}

