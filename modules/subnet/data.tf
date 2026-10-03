data "azurerm_resource_group" "rg" {
  for_each = var.subnet
  name     = each.value.rg_name
}
data "azurerm_virtual_network" "vnet" {
  for_each            = var.subnet
  name                = each.value.vnet_name
  resource_group_name = each.value.rg_name
}
