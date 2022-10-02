variable "admin_username" {
  sensitive = true
  type      = string
  default   = "azureuser"
}

variable "admin_password" {
  sensitive = true
  type      = string
  default   = "qwerty@12345678"
}

variable "sql_login" {
  sensitive = true
  type      = string
  default   = "sqladmin"
}

variable "sql_pass" {
  sensitive = true
  type      = string
  default   = "qwerty@12345678"
}

variable "vm_size" {
  sensitive = false
  type      = string
  default   = "Standard_B2S"

    validation {
    condition     = contains(["Standard_B2S","Standard_B4s"], var.vm_size)
    error_message = "VM Size is not allowed."
  } 
}

variable "vmcount" {
  type        = number
  default     = 1

  validation {
    condition     = var.vmcount >= 1 && var.vmcount <= 3 && floor(var.vmcount) == var.vmcount
    error_message = "Accepted values: 1-3."
  }
}

variable "fd_name" {
  sensitive = false
  type      = string
}

variable "app_plan_name" {
  sensitive = false
  type      = string
}

variable "app_name" {
  sensitive = false
  type      = string
}
