variable "buildby" {
  description = "Name of the builder."
  default     = "Racker Name"
}

variable "buildticket" {
  description = "Ticket Number for the build"
  default     = "Ticket Number"
}

variable "environment" {
  description = "Production, Development, etc"
  default     = "Production"
}

variable "location" {
  description = "Azure region resource resides within"
  default     = "UK South"
}

##########################
# Storage Account Settings
##########################
variable "sa_rsg" {
  description = "Resource Group which the Storage Account should reside within."
  default     = ""
}

variable "sa_name" {
  description = "Name of the Storage Account. Must be between 3-24 characters long, alphanumeric, and lower case."
  default     = ""
}

variable "sa_tier" {
  description = "Storage Account tier. Either Standard or Premium. Premium not supported for BlobStorage."
  default     = ""
}

variable "sa_kind" {
  description = "The kind of Storage Account. Either Storage, StorageV2, or BlobStorage."
  default     = ""
}

variable "sa_replication" {
  description = "The replication type for the Storage Account. Either LRS, GRS, RAGRS, or ZRS. BlobStorage does not support ZRS. Premium tier only supports LRS."
  default     = ""
}

variable "sa_access_tier" {
  description = "Access tier for the Storage Account. Either Hot or Cool. Storage kind does not support access tiers. Remove this line from plan."
  default     = ""
}
