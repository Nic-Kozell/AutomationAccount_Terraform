resource "azurerm_automation_account" "aa" {
  name = "${var.automation_account_name}"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
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




# "${data.azurerm_key_vault_secret.tfstatekey.value}"


# provider "azurerm" {
#   features {}
# }

# resource "azurerm_resource_group" "rg" {
#   name     = "${var.resource_group}"
#   location = "${var.location}"
# }


#   depends_on = [
#      "${var.resource_group}"
#   ]
# }

# resource "azurerm_template_deployment" "source_control_arm" {
#   name = "automationSourceControl"
#   resource_group_name = var.resource_group
#   deployment_mode = "Incremental"
#   depends_on = [
#     azurerm_automation_account.aa
#   ]
#   template_body = file("templates/sourceControl.json")
# }

# resource "azurerm_role_assignment" "aaPermisions" {
#   scope                = azurerm_automation_account.aa.id
#   role_definition_name = "Contributor"
#   principal_id         = "${azurerm_automation_account.aa.identity[0].principal_id}"
# }


# resource "azurerm_key_vault" "keys" {
#   name = "${var.keyvault}"
#   location =  "${var.location}"
#   resource_group_name = "${var.resource_group}"
#   sku_name = "standard"
#   tenant_id = "${var.tenant_id}"
#   soft_delete_retention_days  = 7
#   purge_protection_enabled    = false
# }

# resource "azurerm_key_vault_access_policy" "keys" {
#   key_vault_id = azurerm_key_vault.keys.id
#   tenant_id = "${var.tenant_id}"
#   object_id = "${azurerm_automation_account.aa.identity[0].principal_id}"
#   key_permissions = [
#     "Get",
#     "List"
#   ]
#   secret_permissions = [
#     "Get",
#     "List"
#   ]
# }
##this was to give my account access to to the key vault for testing things
# resource "azurerm_key_vault_access_policy" "keytwo" {
#   key_vault_id = azurerm_key_vault.keys.id
#   tenant_id = "${var.tenant_id}"
#   object_id = "03e4551f-5fc1-43e0-93c3-c501214a28bc"
#   secret_permissions = [
#     "Get",
#     "List",
#     "Set"
#   ]
# }


##TODO work out how to inject a powershell module in to this so that I can setup source control with GIT before creating the webhook
# do powershell | depends on powershell and runbook creation | set webhook
##Also need to add some steps to make the AA managed identity a Contributor on the AA account. 

## script out the github source stuff with a github key in keyvault
## also how do i refresh that token with a script?

# resource "azurerm_key_vault_secret" "appID" {
#   name         = "kozelltestMfaEnrollmentAppId"
#   value        = "d53c19f4-6865-452c-92c8-2f57d689ced1"
#   key_vault_id = azurerm_key_vault.keys.id
# }

# resource "azurerm_key_vault_secret" "appSecret" {
#   name         = "kozelltestMfaEnrollmentAppSecret"
#   value        = "Kb48Q~HDYeQu_Bv3WRa3ejlTVR1cqbD0JsWyFbIe"
#   key_vault_id = azurerm_key_vault.keys.id
# }

#leaving this here as an example but as this module already exists out of the box this will not work
# resource "azurerm_automation_module" "az" {
#   name = "Az"
#   resource_group_name = "${var.resource_group}"
#   automation_account_name = azurerm_automation_account.aa.name

#   module_link {
#     uri = "https://www.powershellgallery.com/packages/Az/7.5.0"
#   }
# }

# resource "azurerm_automation_runbook" "aa"{
#   name = "Check-MFA-Enrollment"
#   location = var.location
#   resource_group_name = var.resource_group
#   automation_account_name = azurerm_automation_account.aa.name
#   log_progress = true
#   log_verbose = true
#   description = "Checks if MFA has been enrolled for a user."
#   runbook_type = "PowerShell"
  
#   publish_content_link {
#     uri = "https://raw.githubusercontent.com/Nic-Kozell/AzureADScripts/main/checkMfaEnroll.ps1"
#   }
# }

# resource "azurerm_automation_webhook" "webhook" {
#   name = "CheckMFA_WebHook"
#   resource_group_name = "${var.resource_group}"
#   automation_account_name = azurerm_automation_account.aa.name
#   enabled = true
#   runbook_name = azurerm_automation_runbook.aa.name
#   expiry_time = "2031-12-31T00:00:00Z"
# }
