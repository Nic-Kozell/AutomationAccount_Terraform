output "automation_account_id" {
    description = "Automation account id"
    value = azurerm_automation_account.aa.id
}

output "automation_account_identity" {
    description = "Automation account identity principal"
    value = ${azurerm_automation_account.aa.identity[0].principal_id}
}
