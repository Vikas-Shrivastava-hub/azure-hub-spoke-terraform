data "azurerm_resource_group" "rg" {
  for_each = var.pip
  name     = each.value.rg_name
}
