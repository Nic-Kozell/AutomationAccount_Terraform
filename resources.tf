resource "azurerm_automation_account" "aa" {
  name = "${var.automation_account}"
  location = "${var.location}"
  resource_group_name = "${var.resource_group}"
  sku_name = "Basic"
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_monitor_diagnostic_setting" "aa_monitor_settings" {
    count = var.enable_diagnostic_settings ? 1:0

    name                       = var.aa_diagnostic_settings.name
    target_resource_id         = azurerm_automation_account.automation_account.id
    log_analytics_workspace_id = var.aa_diagnostic_settings.log_analytics_workspace_id 
    
    log {
        category = "JobLogs"
        enabled  = false
        retention_policy {
            enabled = true
            days    = 30
        }
    }
    
    metric {
        category = "AllMetrics"
        enabled  = true
        retention_policy {
            enabled = true
            days    = 30
        }
    }
}
