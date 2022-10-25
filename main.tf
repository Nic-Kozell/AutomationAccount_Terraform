# "${data.azurerm_key_vault_secret.tfstatekey.value}"


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}

resource "azurerm_automation_account" "aa" {
  name = "${var.automation_account}"
  location = "${var.location}"
  resource_group_name = "${var.resource_group}"
  sku_name = "Basic"
  identity {
    type = "SystemAssigned"
  }
  depends_on = [
    azurerm_resource_group.rg
  ]
}
