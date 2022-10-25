variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Location of resource group"
}

variable "automation_account_name" {
  type        = string
}


variable "sku_name" {
  type        = string
  description = "Only Basic SKU available at present"
  default     = "Basic"
}

variable "enable_diagnostic_settings" {
  type        = bool
  description = "True/False value to choose whether or not to send Automation Account Diagnostic logs to a Log Analytics Workspace."
  default     = false
}

variable "aa_diagnostic_settings" {
    type = object({
        name                       = string
        log_analytics_workspace_id = string
    })
    description = "Configuration details for the diagnostic settings and destination (if deployed)."
    default     = null
}


