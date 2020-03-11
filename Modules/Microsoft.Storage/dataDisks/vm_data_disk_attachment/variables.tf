variable "vm_id" {
  description = "ID of the Virtual Machine to attach the disk to."
}

variable "disk_id" {
  type        = list(string)
  description = "ID of the disk that needs to be attached."
}

variable "caching" {
  type        = list(string)
  description = "Type of caching to use. Either None, ReadOnly, or ReadWrite."
}

variable "write_accelerator_enabled" {
  description = "Whether to enable Write Accelerator. Boolean value."
}

variable "disk_count" {
  description = "Number of disks to attach"
}

