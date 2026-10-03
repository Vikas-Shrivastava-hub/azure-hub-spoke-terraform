resource "azurerm_subnet_route_table_association" "assocaition" {
  for_each       = var.associated
  route_table_id = data.azurerm_route_table.udr[each.key].id
  subnet_id      = data.azurerm_subnet.subnet[each.key].id
}
