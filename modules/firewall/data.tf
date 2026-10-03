data "azurerm_resource_group" "rg" {
  for_each = var.firewall
  name     = each.value.rg_name
}
 