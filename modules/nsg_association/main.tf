resource "azurerm_subnet_network_security_group_association" "association" {
  for_each                  = var.associate
  network_security_group_id = data.azurerm_network_security_group.nsg[each.key].id
  subnet_id                 = data.azurerm_subnet.subnet[each.key].id
}
