/* Configure Azure Provider and declare all the Variables that will be used in Terraform configurations */
provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

#Variables for entire enviroment.
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

#############################
# Public IP Details
#############################
variable "public_ip_sku" {
  description = "Options are Standard or Basic. If creating a v2 Application Gateway you must select Standard"
  default     = "Basic"
}

variable "public_ip_allocation" {
  description = "Options are Dynamic or Static. If creating a v2 Application Gateway you must select Static"
  default     = "Dynamic"
}

#############################
# Application Gateway Details
#############################
variable "agw_vnet_rsg" {
  description = "Name of the Resource Group that the Virtual Network resides within."
  default     = ""
}

variable "agw_vnet_name" {
  description = "Name of the Virtual Network to attach the Application Gateway to."
  default     = ""
}

variable "agw_vnet_subnet_name" {
  description = "Name of the subnet which the Application Gateway will reside within."
  default     = ""
}

variable "agw_rsg" {
  description = "Resource Group the Application Gateway should be built in."
  default     = ""
}

variable "agw_name" {
  description = "Name of the Application Gateway"
  default     = ""
}

#If WAF is required.  You will need to uncommnet lines 76 thru 83 in agw.tf
variable "agw_size" {
  description = "Size of the Application Gateway. Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2"
  default     = "Standard_Medium"
}

#If WAF is required.  You will need to uncommnet lines 77 thru 84 in agw.tf
variable "agw_tier" {
  description = "SKU of the Application Gateway. Either Standard, Standard_v2, WAF, or WAF_v2"
  default     = "Standard"
}

variable "agw_capacity" {
  description = "Number of servers. Between 1 and 10."
  default     = 2
}

variable "agw_cookie_affinity" {
  description = "Enable or disable cookie based affinity."
  default     = "Enabled"
}

variable "agw_ssl_name" {
  description = "Name of the SSL certificate"
  default     = "example.local"
}

variable "agw_ssl_data" {
  description = "Base64 encoded PFX certificate file.  Windows: [System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes('C:\\filename.pfx'))  Linux: base64 filename.pfx"
  default     = "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"
}

variable "agw_ssl_password" {
  description = "Password for the PFX certificate"
  default     = "example"
}

#Only applicable if using WAF SKU
variable "agw_waf_enable" {
  description = "Enable WAF on the Application Gateway."
  default     = false
}

#Only applicable if using WAF SKU
variable "agw_waf_mode" {
  description = "WAF firewall mode to set. Either Detection or Prevention."
  default     = "Detection"
}

