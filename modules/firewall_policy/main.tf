resource "azurerm_firewall_policy" "policy" {
  for_each            = var.firewall_policy
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
  location            = data.azurerm_resource_group.rg[each.key].location
  sku                 = each.value.sku
}
