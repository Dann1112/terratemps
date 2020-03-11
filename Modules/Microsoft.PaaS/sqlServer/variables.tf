variable "buildby" {
  description = "Name of the builder."
}

variable "buildticket" {
  description = "Ticket Number for the build"
}

variable "environment" {
  description = "PRD,QA,STG,DEV,etc."
}

variable "rsg" {
  description = "Resource Group to create the SQL Server in."
}

variable "location" {
  description = "Azure region"
}

variable "name" {
  description = "Name of the database. Needs to be globally unique. Refer to naming standards."
}

variable "ver" {
  description = "The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
}

variable "admin_name" {
  description = "The administrator login name for the new server"
}

variable "admin_password" {
  description = "administrator password"
}

