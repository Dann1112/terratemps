variable "vm_id" {
  description = "Name of the VM you are creating the extension on"
  type        = list(string)
}

variable "vm_count" {
  description = "Number of VMs"
}

variable "workspace_id" {
  description = "Workspace ID of OMS workspace the VM should join"
}

variable "workspace_key" {
  description = "The key of the OMS workspace the VM should join"
}

