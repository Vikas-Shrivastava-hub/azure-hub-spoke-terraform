resource "azurerm_route_table" "udr" {
    for_each = var.udr
    name = each.value.name
    resource_group_name = data.azurerm_resource_group.rg[each.key].name
    location = data.azurerm_resource_group.rg[each.key].location
    dynamic "route" {
        for_each = each.value.route != null ? each.value.route : []
        content {
          name = route.value.name
          address_prefix = route.value.address_prefix
          next_hop_type = route.value.next_hop_type
          next_hop_in_ip_address = var.next_hop_in_ip_address
        }
    }
    bgp_route_propagation_enabled = lookup(each.value, "bgp_route_propagation_enabled", null)
}