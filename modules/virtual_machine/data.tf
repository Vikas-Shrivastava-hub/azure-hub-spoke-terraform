data "azurerm_key_vault" "kv" {
  for_each            = var.vm
  name                = each.value.key_vault_name
  resource_group_name = each.value.kv_rg_name
}
data "azurerm_key_vault_secret" "kv_secret" {
  for_each     = var.vm
  name         = each.value.secret_name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
data "azurerm_resource_group" "rg" {
  for_each = var.vm
  name     = each.value.rg_name
}
data "azurerm_network_interface" "nic" {
  for_each            = var.vm
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
}
