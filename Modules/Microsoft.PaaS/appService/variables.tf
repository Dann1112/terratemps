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
  description = "Azure region for the resource."
}

variable "asp_name" {
  description = "name of the app service plan to use"
}

variable "asp_rsg" {
  description = "name of the rsg where the app service plan resides"
}

variable "app_name" {
  description = "Name of the App Service"
}

variable "rsg" {
  type        = string
  description = "Resource Group to Create the App Service Plan in"
}

variable "https" {
  description = "(Optional) Can the App Service only be accessed via HTTPS? Defaults to false."
}

variable "dotnet" {
  description = "(Optional) Defaults to v4.0. The version of the .net framework's CLR used in this App Service. Possible values are v2.0 (which will use the latest version of the .net framework for the .net CLR v2 - currently .net 3.5) and v4.0 (which corresponds to the latest version of the .net CLR v4 - which at the time of writing is .net 4.7.1)"
}

variable "always_on" {
  description = " (Optional) Should the app be loaded at all times? Defaults to false."
}

