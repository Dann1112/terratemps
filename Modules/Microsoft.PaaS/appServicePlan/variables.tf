variable "buildby" {
  description = "Name of the builder."
}

variable "buildticket" {
  description = "Ticket Number for the build"
}

variable "location" {
  description = "Azure region for the resource."
}

variable "environment" {
  description = "Prod,QA,STG,DEV,etc."
}

variable "asp_name" {
  description = "Name of the App Service Plan"
}

variable "rsg" {
  type        = string
  description = "Resource Group to Create the App Service Plan in"
}

variable "kind" {
  description = "The kind of the App Service Plan to create. Possible values are Windows (also available as App), Linux, elastic (for Premium Consumption) and FunctionApp (for a Consumption Plan)."
}

variable "tier" {
  description = "Specifies the plan's pricing tier."
}

variable "size" {
  description = "Specifies the plan's instance size."
}

variable "capacity" {
  description = "(Optional) Specifies the number of workers associated with this App Service Plan."
}

