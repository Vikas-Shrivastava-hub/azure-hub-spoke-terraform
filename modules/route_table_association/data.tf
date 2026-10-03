data "azurerm_subnet" "subnet" {
  for_each             = var.associated
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}
data "azurerm_route_table" "udr" {
  for_each            = var.associated
  name                = each.value.table_name
  resource_group_name = each.value.rg_name
}
