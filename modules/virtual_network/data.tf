data "azurerm_resource_group" "rg" {
  for_each = var.vnet
  name     = each.value.rg_name
}
