variable "buildby" {
  description = "Name of the builder."
}

variable "buildticket" {
  description = "Ticket Number for the build"
}

variable "environment" {
  description = "PRD,QA,STG,DEV,etc."
}

variable "location" {
  description = "Azure region"
}

variable "server_name" {
  description = "SQL server to store the database"
}

variable "server_rsg" {
  description = "Resource Group of the SQL Server"
}

variable "rsg" {
  description = "Resource Group to create the SQL Server in."
}

variable "name" {
  description = "Name of the database. Needs to be globally unique. Refer to naming standards."
}

variable "edition" {
  description = "The edition of the database to be created.  Valid values are: Basic, Standard, Premium, DataWarehouse, Business, BusinessCritical, Free, GeneralPurpose, Hyperscale, Premium, PremiumRS, Standard, Stretch, System, System2, or Web."
}

variable "performance" {
  description = "set the performance level for the database. Valid values are located at https://azure.microsoft.com/en-us/pricing/details/sql-database/single/"
}

variable "collation" {
  description = "The name of the collation"
  default     = "SQL_LATIN1_GENERAL_CP1_CI_AS"
}

