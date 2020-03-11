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
  description = "Prod,QA,STG,DEV,etc."
  default     = "Production"
}

variable "location" {
  description = "Azure region the environment."
  default     = "UK South"
}

#####################
# Subnet Details
#####################
variable "vnet_rsg_name" {
  description = "Name of the Resource Group the existing Virtual Network resides in."
  default     = "LOC-RSG-NET-ENV"
}

variable "vnet_name" {
  description = "Name of the existing Virtual Network."
  default     = "LOC-VNET01"
}

variable "aks_subnet_name" {
  description = "Name of Kubernetes subnet."
  default     = "LOC-VNET01-AKS-ENV"
}

#####################
# OMS Details
#####################
variable "oms_name" {
  description = "Name of the OMS workspace"
  default     = "xxxxxxx-OMS"
}

variable "oms_resource_group" {
  description = "Resource Group that the OMS workspace resides in"
  default     = "LOC-RSG-ALL-ENV"
}

#####################
# AKS Details
#####################
variable "aks_name" {
  description = "Name of the AKS to create."
  default     = "LOC-ENV-AKS"
}

variable "acr_name" {
  description = "Name of the Azure Container Registry to create. must be in lowercase. no dashes or underscores"
  default     = "locenvacr"
}

variable "aks_dns" {
  description = "DNS prefix for the AKS cluter."
  default     = "locenvaks"
}

# Check latest version at https://github.com/Azure/AKS/blob/master/CHANGELOG.md
variable "aks_version" {
  description = "Version of Kubernetes to use"
  default     = "1.12.7"
}

variable "aks_agent_pool_name" {
  description = "Name of the agent pool"
  default     = "poolname01"
}

variable "aks_agent_os" {
  description = "OS type for the agent"
  default     = "Linux"
}

variable "aks_agent_size" {
  description = "SKU size for the agent nodes"
  default     = "Standard_D2s_v3"
}

variable "aks_agent_disk_size" {
  description = "Size of the disk presented to the agents in GiB"
  default     = 32
}

variable "aks_agent_number" {
  description = "Number of agent nodes required"
  default     = 3
}

variable "aks_address_range" {
  description = "Internal k8s address range"
  default     = "10.0.0.0/16"
}

variable "aks_dns_ip" {
  description = "Internal IP to use for DNS"
  default     = "10.0.0.10"
}

variable "aks_docker_bridge" {
  description = "Internal docker bridge address range"
  default     = "172.17.0.1/16"
}

variable "aks_spn_id" {
  description = "Client ID of the Service Principal account to use"
}

variable "aks_spn_secret" {
  description = "Secret associated with the Service Principal account to use"
}

