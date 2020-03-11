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

variable "performance" {
  description = "set the performance level for the database. Valid values are located at https://azure.microsoft.com/en-us/pricing/details/sql-database/single/"
  default     = "ElasticPool"
}

variable "pool_name" {
  description = "The name of the elastic database pool"
}

variable "collation" {
  description = "The name of the collation"
  default     = "SQL_LATIN1_GENERAL_CP1_CI_AS"
}

