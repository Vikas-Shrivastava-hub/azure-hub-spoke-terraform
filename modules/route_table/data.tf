data "azurerm_resource_group" "rg" {
  for_each = var.udr
  name     = each.value.rg_name
}
