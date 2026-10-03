resource "azurerm_virtual_network_peering" "vnet_peer_1" {
  for_each                               = var.vnet_peer
  name                                   = each.value.name
  virtual_network_name                   = each.value.local_vnet_name
  remote_virtual_network_id              = data.azurerm_virtual_network.vnet_remote[each.key].id
  resource_group_name                    = each.value.rg_name
  allow_virtual_network_access           = lookup(each.value, "allow_virtual_network_access", null)
  allow_forwarded_traffic                = lookup(each.value, "allow_forwarded_traffic", null)
  allow_gateway_transit                  = lookup(each.value, "allow_gateway_transit", null)
  local_subnet_names                     = lookup(each.value, "local_subnet_names", null)
  only_ipv6_peering_enabled              = lookup(each.value, "only_ipv6_peering_enabled", null)
  peer_complete_virtual_networks_enabled = lookup(each.value, "peer_complete_virtual_networks_enabled", null)
  remote_subnet_names                    = lookup(each.value, "remote_subnet_names", null)
  use_remote_gateways                    = lookup(each.value, "use_remote_gateways", null)
}
