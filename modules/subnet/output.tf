output "subnet_id" {
    value = { for keys, subnet in azurerm_subnet.subnet : keys => subnet.id}
  
}