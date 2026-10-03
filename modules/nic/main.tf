resource "azurerm_network_interface" "nic" {
  for_each            = var.nic
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
  location            = data.azurerm_resource_group.rg[each.key].location
  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
      name                                               = ip_configuration.value.name
      subnet_id                                          = data.azurerm_subnet.subnet[each.key].id
      private_ip_address_allocation                      = ip_configuration.value.private_ip_address_allocation
      gateway_load_balancer_frontend_ip_configuration_id = lookup(ip_configuration.value, "gateway_load_balancer_frontend_ip_configuration_id", null)
      private_ip_address_version                         = lookup(ip_configuration.value, "private_ip_address_version", null)
      public_ip_address_id                               = lookup(ip_configuration.value, "public_ip_address_id", null)
    }
  }
  auxiliary_mode                 = lookup(each.value, "auxiliary_mode", null)
  auxiliary_sku                  = lookup(each.value, "auxiliary_sku", null)
  dns_servers                    = lookup(each.value, "dns_server", [])
  edge_zone                      = lookup(each.value, "edge_zone", null)
  ip_forwarding_enabled          = lookup(each.value, "ip_forwarding_enabled", null)
  accelerated_networking_enabled = lookup(each.value, "accelerated_networking_enabled", null)
  internal_dns_name_label        = lookup(each.value, "internal_dns_name_label", null)
}

