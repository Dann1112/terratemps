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

variable "sas_token" {
  description = "SAS Token of the master environment. Can be found at https://one.rackspace.com/pages/viewpage.action?spaceKey=FSFA&title=Support+Enrollment+-+Greenfield+Subscription"
}

#################
# Tag Information
#################

variable "buildby" {
  description = "Name of the builder."
  default     = "Racker Name"
}

variable "environment" {
  description = "View environment_map listeing below for valid values"
  default     = "Bastion"
}

variable "location" {
  default = "North Europe"
}

#################
# Network Details
#################

variable "vnet_name" {
  description = "Name of the existing VNET"
  default     = "LOC-VNET01"
}

variable "vnet_rsg" {
  description = "Name of the existing RSG the VNET is in"
  default     = "LOC-RSG-NET-PRD"
}

variable "vnet_rbast_subnet_name" {
  default = "LOC-VNET01-RBAST01"
}

#########################
# Virtual Machine Details
#########################

variable "core_account_number" {
  default = "888888"
}

variable "mscloud_subscription_id" {
  description = "MSCloud Subscription ID found in ops.mscloud.rackspace.com"
  default     = "123"
}

variable "vm_unique_number" {
  description = "Bastion number. This appends to rlb (eg. rlb1-xxx-xxxx, rlb2-xxx-xxxx)"
  default     = "1"
}

variable "vm_size" {
  default = "Standard_A1_v2"
}

variable "enrollment_token" {
  default = "eyJzIjoiZDIzYThmZDItYTdlMi00Mzc5LWJlZjEtMzdlMTgzOGEyYTExIiwidSI6Imh0dHBzOi8vYXBwLnNjYWxlZnQuY29tIn0="
}

variable "bastion_scope" {
  description = "Scope of the bastion. Either vnet or global."
  default     = "vnet"
}

variable "dns_servers" {
  description = "List of DNS server IPs to configure on the NIC. Azure default is 168.63.129.16."
  default     = ["168.63.129.16"]
}

#####################
# Mappings
# Do Not Touch
#####################
variable "environment_map" {
  type = map(string)

  default = {
    "Production"        = "PRD"
    "Staging"           = "STG"
    "Test"              = "TST"
    "Development"       = "DEV"
    "Disaster Recovery" = "DR"
    "Management"        = "MGT"
    "Shared"            = "SHD"
    "QA"                = "QA"
  }
}

variable "zones_map" {
  type = map(string)

  default = {
    "East US"              = "EUS"
    "East US 2"            = "EU2"
    "Central US"           = "CUS"
    "North Central US"     = "NCU"
    "South Central US"     = "SCU"
    "West Central US"      = "WCU"
    "West US"              = "WUS"
    "West US 2"            = "WU2"
    "Canada East"          = "CAE"
    "Canada Central"       = "CAC"
    "Brazil South"         = "BZS"
    "North Europe"         = "NEU"
    "West Europe"          = "WEU"
    "France Central"       = "FRC"
    "France South"         = "FRS"
    "UK West"              = "UKW"
    "UK South"             = "UKS"
    "Germany Central"      = "GEC"
    "Germany Northeast"    = "GNE"
    "Germany North"        = "GNO"
    "Germany West Central" = "GWC"
    "Switzerland North"    = "SZN"
    "Switzerland West"     = "SZW"
    "Southeast Asia"       = "SEA"
    "East Asia"            = "EAS"
    "Australia East"       = "AEA"
    "Australia Southeast"  = "ASE"
    "Australia Central"    = "ACE"
    "Australia Central 2"  = "AC2"
    "Central India"        = "CIN"
    "West India"           = "WIN"
    "South India"          = "SIN"
    "Japan East"           = "JEA"
    "Japan West"           = "JPW"
    "Korea Central"        = "KOC"
    "Korea South"          = "KOS"
    "South Africa West"    = "SAW"
    "South Africa North"   = "SAN"
  }
}

variable "zones_name_map" {
  type = map(string)

  default = {
    "East Asia"           = "eastasia"
    "Southeast Asia"      = "southeastasia"
    "Central US"          = "centralus"
    "East US"             = "eastus"
    "East US 2"           = "eastus2"
    "West US"             = "westus"
    "North Central US"    = "northcentralus"
    "South Central US"    = "southcentralus"
    "North Europe"        = "northeurope"
    "West Europe"         = "westeurope"
    "Japan West"          = "japanwest"
    "Japan East"          = "japaneast"
    "Brazil South"        = "brazilsouth"
    "Australia East"      = "australiaeast"
    "Australia Southeast" = "australiasoutheast"
    "South India"         = "southindia"
    "Central India"       = "centralindia"
    "West India"          = "westindia"
    "Canada Central"      = "canadacentral"
    "Canada East"         = "canadaeast"
    "UK South"            = "uksouth"
    "UK West"             = "ukwest"
    "West Central US"     = "westcentralus"
    "West US 2"           = "westus2"
    "Korea Central"       = "koreacentral"
    "Korea South"         = "koreasouth"
    "France Central"      = "francecentral"
    "France South"        = "francesouth"
    "Australia Central"   = "australiacentral"
    "Australia Central 2" = "australiacentral2"
    "South Africa North"  = "southafricanorth"
    "South Africa West"   = "southafricawest"
  }
}

