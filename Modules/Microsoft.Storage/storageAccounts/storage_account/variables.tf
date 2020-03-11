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
  description = "Azure region for the environment."
  default     = ""
}

#########################
# Storage Account Details
#########################

variable "sa_rsg" {
  description = "Resource Group which the Storage Account should reside within."
  default     = "LOC-RSG-APP-ENV"
}

variable "sa_name" {
  description = "Name of the Storage Account. Must be between 3-24 characters long, alphanumeric, and lower case."
  default     = "storagename"
}

variable "sa_tier" {
  description = "Storage Account tier. Either Standard or Premium. Premium not supported for BlobStorage."
  default     = "Standard"
}

variable "sa_kind" {
  description = "The kind of Storage Account. Either Storage, StorageV2, or BlobStorage."
  default     = "StorageV2"
}

variable "sa_replication" {
  description = "The replication type for the Storage Account. Either LRS, GRS, RAGRS, or ZRS. BlobStorage does not support ZRS. Premium tier only supports LRS."
  default     = "LRS"
}

variable "sa_access_tier" {
  description = "Access tier for the Storage Account. Either Hot or Cool. Storage kind does not support access tiers. Remove this line from plan."
  default     = "Hot"
}

