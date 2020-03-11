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

variable "max_size" {
  description = "The max data size of the elastic pool in gigabytes"
}

variable "sku_name" {
  description = "Specifies the SKU Name for this Elasticpool.  DTU based BasicPool, StandardPool, or PremiumPool pattern"
}

variable "capacity" {
  description = "The scale up/out capacity in DTUs"
}

variable "tier" {
  description = "The tier of the particular SKU. Possible values are Basic, Standard, or Premium"
}

variable "min_capacity" {
  description = "The minimum capacity all databases are guaranteed."
  default     = 0
}

variable "max_capacity" {
  description = "The minimum capacity all databases are guaranteed. Must match the capacity variable."
}

