variable "buildby" {
  description = "Name of the builder."
}

variable "buildticket" {
  description = "Ticket Number for the build"
}

variable "environment" {
  description = "Prod,QA,STG,DEV,etc."
}

variable "location" {
  description = "Azure Region to deploy to."
}

variable "csr_count" {
  description = "How many CSR devices are currently in this Azure region"
}

variable "vnet_address_space" {
  description = "address range for vnet."
}

variable "first_subnet_range" {
  description = "IP range for the first subnet"
}

variable "second_subnet_range" {
  description = "IP range for the second subnet"
}

variable "accelerated_networking" {
  description = "Choose to enable accelerated networking.  Allowed Vaules are true and false. default to false"
}

variable "admin_password" {
  description = "password for all VMs"
}

variable "vm_size" {
  description = "Size of the VM you want to create"
}

#####################
# Mappings
# Do Not Touch
#####################

variable "environment_map" {
  type = map(string)

  default = {
    "Production"        = "p"
    "Staging"           = "s"
    "Test"              = "t"
    "Development"       = "d"
    "Disaster Recovery" = "dr"
    "UAT"               = "ua"
  }
}

variable "zones_map" {
  type = map(string)

  default = {
    "East US"          = ""
    "Central US"       = ""
    "North Central US" = ""
    "South Central US" = ""
    "West Central US"  = ""
    "West US 2"        = ""
    "Brazil South"     = ""
    "West Europe"      = ""
    "Southeast Asia"   = ""
    "Australia East"   = ""
    "Central India"    = ""
    "South India"      = ""
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
    "West US 2"           = "westus2"
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

