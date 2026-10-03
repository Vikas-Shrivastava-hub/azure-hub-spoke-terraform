data "azurerm_virtual_network" "vnet_remote" {
  for_each            = var.vnet_peer
  name                = each.value.remote_vnet_name
  resource_group_name = each.value.remote_rg_name
}
