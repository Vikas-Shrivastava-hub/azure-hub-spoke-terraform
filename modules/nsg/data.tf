data "azurerm_resource_group" "rg" {
  for_each = var.nsg
  name     = each.value.rg_name
}
