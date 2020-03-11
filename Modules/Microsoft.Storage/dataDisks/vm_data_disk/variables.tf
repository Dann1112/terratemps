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
  type        = string
  description = "Azure region for the environment."
}

variable "disk_rsg" {
  description = "Resource Group to create the disk in."
}

variable "vm_name" {
  description = "Name for the disk you are creating"
}

variable "disk_count" {
  description = "Number of disks to create"
}

variable "disk_type" {
  description = "Type of storage to use. Either Standard_LRS, Premium_LRS, StandardSSD_LRS, or UltraSSD_LRS."
}

variable "disk_size_gb" {
  description = "Size of the disk to create in GB."
}

